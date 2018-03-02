# coding: utf-8

module Reapal
  module Api
    module Order
      module QueryByFlowId

        # 4.3  订单号查询（批量）
        #
        # @param flow_id [String] 业务订单号【对应还款、债权转让、投标撤销、满标操作订单号】
        # @param service_type [Symbol] 查询类型，取值如下
        #   * :tender_cancel 投标撤销查询
        #   * :tender_finish 满标查询
        #   * :tender_refund 还款查询
        #   * :tender_transfer 债权转让查询查询
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #      * :orderNo [String] 商户订单号
        #      * :resultCode [String] 结果代码
        #      * :failDetails [String] 失败明细
        #          * :seriaNo [String] 业务流水号
        #          * :errorCode [String] 错误代码
        #          * :errorMsg [String]  错误信息
        #
        def query_by_flow_id(flow_id, service_type)
          service = case service_type.to_sym
                    when :tender_cancel
                      'reapal.trust.tenderCancelMQuery'
                    when :tender_finish
                      'reapal.trust.tenderFinishMQuery'
                    when :tender_refund
                      'reapal.trust.tenderRefundMQuery'
                    when :tender_transfer
                      'reapal.trust.tenderTransferMQuery'
                    else
                      nil
                    end

          if service.nil?
            res[:result] = "F"
            res[:error_msg] = "参数 service_type 错误"
            return res
          end

          post_path = '/tender/rest.htm'

          params = {
            orderNo: flow_id,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:query, service, params, post_path, Http::ErrorCode.query_by_flow_id, ['0000'])

          if 'P' == res[:result] && ('0001' || '0003') == res[:data][:resultCode]
            res[:result] = 'F'
          end

          Reapal.logger.info res

          res
        end

      end # module QueryByFlowId
    end
  end
end
