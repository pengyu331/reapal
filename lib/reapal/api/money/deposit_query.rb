# coding: utf-8

module Reapal
  module Api
    module Trust
      module DepositQuery

        # 2.6 充值查询（API）
        #
        # @param deposit_order_no [ String ] 充值订单号
        #
        # @return [ Hash ] 结果集
        #   * :result [String] "S"/"F"/"P"
        #   * :error_msg [String] 错误提示
        #   * :data [Hash] 成功数据
        #       * :orderNo [String]  充值订单号
        #       * :amount [BigDecimal] 交易金额
        #       * :charge [BigDecimal] 手续费
        #       * :resultCode [String] 结果代码
        #
        def deposit_query(deposit_order_no)
          service = 'reapal.trust.depositQuery'
          post_path = '/reagw/service/depwit.htm'

          params = {
            orderNo: deposit_order_no,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          if Api::ErrorCode.deposit_query.include?(response.data[:errorCode])
            res[:result] = 'F'
            return res
          end

          # 查询类 api，http 没成功都返回 pending
          return res unless response.http_success?

          # 其余 api 错误不知道
          return res unless response.data[:errorCode].nil?

          res[:result] = "S"

          res
        end

      end # module
    end
  end
end
