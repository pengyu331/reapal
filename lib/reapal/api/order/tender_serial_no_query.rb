# coding: utf-8
module Reapal
  module Api
    module Order
      module TenderSerialNoQuery

        # 4.1 流水号查询（API）
        #
        # @param serial_no [ String ] 业务流水号（对应满标、还款分账明细的流水号）
        # @param service_type [Symbol] 查询类型，取值如下
        #   * :tender_finish 满标查询
        #   * :tender_refund 还款查询
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #     * :serialNo [String] 业务流水号
        #     * :resultCode [String] 结果代码 0000：处理成功；0001：处理失败；0002：处理中
        #
        def tender_serial_no_query(serial_no, service_type)
          service = case service_type.to_sym
                    when :tender_finish
                      'reapal.trust.tenderFinishSQuery'
                    when :tender_refund
                      'reapal.trust.tenderRefundSQuery'
                    else
                      nil
                    end

          if service.nil?
            res[:result] = "F"
            res[:error_msg] = "参数 service_type 错误"
            return res
          end

          post_path = '/reagw/tender/rest.htm'

          params = {
            serialNo: serial_no,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
          }

          res = operate_post(:query, service, params, post_path, Http::ErrorCode.tender_auth_query, ['0000'])

          if 'S' == res[:result] && ('0001' || '0003') == res[:data][:resultCode]
            res[:result] = 'F'
          end

          res
        end

      end # module Agree
    end
  end
end
