# coding: utf-8

module Reapal
  module Api
    module Money
      module MemberPaymentQuery

        # 2.7 会员缴费查询
        #
        # @param member_payment_flow_id [ String ] 缴费订单号
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #     * :orderNo [String] 缴费订单号
        #     * :amount [String] 缴费金额
        #     * :resultCode [String] 结果代码 0000：缴费成功 0001:失败
        #
        def member_payment_query(member_payment_flow_id)
          service = 'reapal.trust.memberPaymentQuery'
          post_path = '/tender/rest.htm'

          params = {
            orderNo: member_payment_flow_id,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:query, service, params, post_path, Http::ErrorCode.member_payment_query, ['0000'])

          if 'P' == res[:result] && '0001' == res[:data][:resultCode]
            res[:result] = 'F'
          end

          Reapal.logger.info res

          res
        end

      end
    end
  end
end
