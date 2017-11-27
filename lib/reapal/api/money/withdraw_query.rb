# coding: utf-8

module Reapal
  module Api
    module Money
      module WithdrawQuery

        # 2.8 提现查询（API）
        #
        # @param withdraw_flow_id [ String ] 提现订单号
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #       * :orderNo [String]  提现订单号
        #       * :amount [BigDecimal] 交易金额
        #       * :userName [String] 用户姓名
        #       * :bankName [String] 提现银行
        #       * :bankCard [String] 提现银行卡后四位
        #       * :resultCode [String] 结果代码 0000：申请成功（待出款）0002：提现成功 0003：提现失败
        #
        def withdraw_query(withdraw_flow_id)
          service = 'reapal.trust.withdrawQuery'
          post_path = '/reagw/service/depwit.htm'

          params = {
            orderNo: withdraw_flow_id,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:query, service, params, post_path, Http::ErrorCode.withdraw_query, ['0002'])

          if 'S' == res[:result] && '0003' == res[:data][:resultCode]
            res[:result] = 'F'
          end

          res
        end

      end # module
    end
  end
end
