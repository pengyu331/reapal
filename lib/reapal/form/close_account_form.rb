# coding: utf-8

module Reapal
  module Form
    module CloseAccountForm

      # 1.11 取消签约
      #
      # @param flow_id [String] 流水号
      # @param contract [String] 用户协议
      # @param return_url [String] 回调 url
      # @param notify_url [String] 通知 url
      # @param busway [String] 设备通道，默认手机端。00：PC端；01：手机端；02：Pad端；03：其它
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
      def close_account_form(flow_id, contract, return_url, notify_url, busway='01')
        service = 'reapal.trust.closeAccount'
        post_path = '/reagw/agreement/closeAccountApply.htm'

        params = {
          orderNo: flow_id,
          contracts: contract,
          busway: busway,
          returnUrl: return_url,
          notifyUrl: notify_url,
          applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
        }

        get_form_data(service, params, post_path)
      end

    end
  end
end
