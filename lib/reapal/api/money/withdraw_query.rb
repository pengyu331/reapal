# coding: utf-8

module Reapal
  module Api
    module Money
      module WithdrawQuery

        # 2.8 提现查询（API）
        #
        # @param withdraw_order_no [ String ] 提现订单号
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
        def withdraw_query(withdraw_order_no)
          service = 'reapal.trust.withdrawQuery'
          post_path = '/reagw/service/depwit.htm'

          params = {
            orderNo: withdraw_order_no,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          # 查询类 api，http 没成功都返回 pending
          return res unless response.http_success?

          # 其余 api 错误不知道
          return res unless response.data[:errorCode].nil?

          if Api::ErrorCode.withdraw_query.include?(response.data[:errorCode])
            res[:result] = 'F'
            return res
          end

          res[:result] = 'S'
          res[:data][:amount] = response.data[:amount].to_d

        end

      end # module
    end
  end
end
