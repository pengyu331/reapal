# coding: utf-8

module Reapal
  module Api
    module Money
      module DepositQuery

        # 2.6 充值查询（API）
        #
        # @param deposit_flow_id [ String ] 充值订单号
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
        def deposit_query(deposit_flow_id)
          service = 'reapal.trust.depositQuery'
          post_path = '/reagw/service/depwit.htm'

          params = {
            orderNo: deposit_flow_id,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:query, service, params, post_path, Http::ErrorCode.deposit_query, ['0000'])

          if 'S' == res[:result] && ('0001' || '0004') == res[:data][:resultCode]
            res[:result] = 'F'
          end

          res
        end

      end # module
    end
  end
end
