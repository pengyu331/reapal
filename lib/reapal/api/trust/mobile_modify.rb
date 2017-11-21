# coding: utf-8

module Reapal
  module Api
    module Trust
      module MobileModify

        # 1.7 签约手机号修改
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
        def mobile_modify(contracts, new_phone, busway='01')
          service = 'reapal.trust.mobileModify'
          post_path = '/reagw/user/rest.htm'

          params = {
            contracts: contracts,
            mobile: new_phone,
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
