# coding: utf-8

module Reapal
  module Api
    module Agreement
      module BalanceQuery

        # 1.6 查询余额（API）
        #
        # @param contracts [ String ] 用户协议号
        #
        # @return [ Hash ] 结果集
        #   * :success [bool] 查询结果是否有效
        #   * :data [Hash] 成功数据
        #       * :total_amount [BigDecimal] 账户总额
        #       * :usable_amount [BigDecimal] 可用金额
        #       * :tender_amount [BigDecimal] 投标金额
        #
        def balance_query(contracts)
          service = 'reapal.trust.balanceQuery'
          post_path = '/reagw/agreement/agreeApi.htm'

          params = {
            contracts: contracts,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          # 如果数据不合法
          unless response.data_valid
            return {success: false}
          end

          # 如果网络出错，包括超时或者非200类数据
          unless response.http_response.kind_of?(Net::HTTPSuccess)
            return {success: false}
          end

          # 如果 api 出异常
          if response.data[:errorCode]
            return {success: false}
          end

          {
            success: true,
            data: {
              total_amount: response.data[:totalAmount].to_d,
              usable_amount: response.data[:usableAmount].to_d,
              tender_amount: response.data[:tenderAmount].to_d,
            }
          }
        end

      end # module Agree
    end
  end
end
