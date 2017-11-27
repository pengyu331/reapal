# coding: utf-8

module Reapal
  module Form
    module WithdrawApplyForm

      # 2.7 提现申请
      #
      # @param contract [String] 用户协议
      # @param flow_id [String] 订单号
      # @param money [Number] 提现金额，2位小数
      # @param charge [Number] 手续费，2位小数
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
      def withdraw_apply_form(contract, flow_id, money, charge, return_url, notify_url, busway='01')
        service = 'reapal.trust.withdrawApply'
        post_path = '/reagw/service/withdraw.htm'

        params = {
          orderNo: flow_id,
          contracts: contract,
          amount: money,
          charge: charge,
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
