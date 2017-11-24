# coding: utf-8

module Reapal
  module Api
    module Trust
      module FindTradePassowrdForm

        # 1.9 设置/修改交易密码
        #
        # @param contract [String] 用户协议
        # @param return_url [String] 回调 url
        # @param notify_url [String] 通知 url
        # @param buyway [String] 设备通道，默认手机端。00：PC端；01：手机端；02：Pad端；03：其它
        #
        # @return [ Hash ] 结果集
        #   * :form_method
        #     * :method
        #     * :url
        #   * :form_data
        #     * :merchant_id
        #     * :encryptkey
        #     * :data
        #
        def find_trade_password_form(contract, return_url, notify_url, busway='01')
          service = 'reapal.trust.findTradePassword'
          post_path = '/reagw/findTradePassword/findTradePassword.htm'

          params = {
            contracts: contract,
            busway: busway,
            returnUrl: return_url,
            notifyUrl: notify_url,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          form_data = Http.get_body(service, params, @config)

          {
            form_method: {
              method: :post,
              url: config[:server_url] + post_path,
            },
            form_data: form_data
          }
        end

      end
    end
  end
end
