# coding: utf-8

module Reapal
  module Api
    module Trust
      module FindTradePassowrd

        # 1.9 设置/修改交易密码
        #
        # @param
        #
        # @return [ Hash ] 结果集
        #   * :merchant_id
        #   * :encryptkey
        #   * :data
        #   * :url
        #   * :method
        #
        def find_trade_password(contracts, returnUrl, notifyUrl, busway='01')
          service = 'reapal.trust.findTradePassword'
          post_path = '/reagw/findTradePassword/findTradePassword.htm'

          params = {
            contracts: contracts,
            busway: busway,
            returnUrl: returnUrl,
            notifyUrl: notifyUrl,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          request = Http.get_body(service, params, @config)
          request[:method] = :post
          request[:url] = config[:server_url] + post_path

          request
        end

      end
    end
  end
end
