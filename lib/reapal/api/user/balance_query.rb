# coding: utf-8

module Reapal
  module Api
    module User
      module BalanceQuery

        # 1.6 查询余额（API）
        #
        # @param contracts [ String ] 用户协议号
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #     * :total_amount [BigDecimal] 账户总额
        #     * :usable_amount [BigDecimal] 可用金额
        #     * :tender_amount [BigDecimal] 投标金额
        #
        def balance_query(contracts)
          service = 'reapal.trust.balanceQuery'
          post_path = '/reagw/agreement/agreeApi.htm'

          params = {
            contracts: contracts,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          # 查询类 api，http 没成功都返回 pending
          return res unless response.http_success?

          # 如果查不到这个人
          if response.data[:errorCode] == '0113'
            res[:result] = 'F'
            return res
          end

          # 其余 api 错误不知道
          return res unless response.data[:errorCode].nil?

          res[:result] = 'S'
          res[:data] = {
            total_amount: response.data[:totalAmount].to_d,
            usable_amount: response.data[:usableAmount].to_d,
            tender_amount: response.data[:tenderAmount].to_d,
          }

          res
        end

      end # module Agree
    end
  end
end
