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
        #     * :totalAmount [BigDecimal] 账户总额
        #     * :usableAmount [BigDecimal] 可用金额
        #     * :tenderAmount [BigDecimal] 投标金额
        #
        def balance_query(contracts)
          service = 'reapal.trust.balanceQuery'
          post_path = '/reagw/agreement/agreeApi.htm'

          params = {
            contracts: contracts,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:query, service, params, post_path, ['0113'], ['0000'])

          if 'S' == res[:result] || ('P' == res[:result] && res[:data][:resultCode].nil?)
            res[:result] = 'S'

            res[:data] = {
              totalAmount: res[:data][:totalAmount].to_d,
              usableAmount: res[:data][:usableAmount].to_d,
              tenderAmount: res[:data][:tenderAmount].to_d,
            }
          end

          Reapal.logger.info res

          res
        end

      end # module Agree
    end
  end
end
