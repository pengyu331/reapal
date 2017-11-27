# coding: utf-8

module Reapal
  module Form
    module CertificateForm

      # 2.5 卡密鉴权
      #
      # @param order_no [String] 订单号
      # @param bind_id [String] 绑卡 ID，调用充值签约接口时，获取的bindId
      # @param contract [String] 借款人协议号
      # @param return_url [String] 回调 url
      # @param notify_url [String] 通知 url
      # @param terminal_type [String] 终端类型，默认手机端。PC端：web 手机端：mobile
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
      def withdraw_apply_form(order_no, bind_id, contract, return_url, notify_url, terminal_type='mobile')
        service = 'reapal.trust.certificate'
        post_path = '/reagw/service/depwit.htm'

        params = {
          orderNo: order_no,
          contracts: contract,
          terminalType: terminal_type,
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
