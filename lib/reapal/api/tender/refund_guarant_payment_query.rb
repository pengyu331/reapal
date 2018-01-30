# coding: utf-8

module Reapal
  module Api
    module Tender
      module RefundGuarantPaymentQuery

        # 3.17  借款人还代偿款查询
        #
        # @param refund_flow_id [ String ] 还款订单号
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #     * :orderNo [String] 订单号
        #     * :amount [Number] 金额
        #     * :resultCode [String] 
        #
        def refund_guarant_payment_query(refund_flow_id)
          service = 'reapal.trust.refundGuarantPaymentQuery'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: flow_id,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:query, service, params, post_path, Http::ErrorCode.refund_guarant_payment_query, ['0000'])

          Reapal.logger.info res

          res
        end

      end # module TenderAuthQuery
    end
  end
end
