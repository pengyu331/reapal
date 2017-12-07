# coding: utf-8

module Reapal
  module Api
    module Order
      module QueryBySingleFlowId

        # 4.2  订单号查询（单笔）
        #
        # @param flow_id [String] 业务订单号【对应发标、投标订单号】
        # @param service_type [Symbol] 查询类型，取值如下
        #   * :tender_apply 发标单笔查询
        #   * :tender_invest 投标单笔查询
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #      * :orderNo [String] 商户订单号
        #      * :realAmount [String] 实际投标金额(只针对投标查询)
        #      * :resultCode [String] 结果代码
        #
        def query_by_single_flow_id(flow_id, service_type)
          service = case service_type.to_sym
                    when :tender_apply
                      'reapal.trust.tenderApplySQuery'
                    when :tender_invest
                      'reapal.trust.tenderInvestSQuery'
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
            orderNo: flow_id,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:query, service, params, post_path, Http::ErrorCode.query_by_single_flow_id, ['0000'])

          if 'S' == res[:result] && ('0001' || '0003') == res[:data][:resultCode]
            res[:result] = 'F'
          end

          res
        end

      end # module QueryBySingleFlowId
    end
  end
end
