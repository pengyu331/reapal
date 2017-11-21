# coding: utf-8

module Reapal
  module Api
    module Trust
      module WithdrawApply

        # 2.7 提现申请
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
        def withdraw_apply(contracts, flow_id, money, charge, busway='01')
          service = 'reapal.trust.withdrawApply'
          post_path = '/reagw/service/withdraw.htm'

          params = {
            orderNo: flow_id,
            contracts: contracts,
            amount: money,
            charge: charge,
            busway: busway,
            returnUrl: '',
            notifyUrl: '',
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
