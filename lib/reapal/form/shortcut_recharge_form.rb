module Reapal
  module Form
    module ShortcutRechargeForm

        # 2.2 快捷充值
        #
        # @param flow_id [ String ] 订单号
        # @param contracts [ String ] 协议号
        # @param money [ Number ] 交易金额
        # @param return_url [String] 回调 url
        # @param notify_url [String] 通知 url
        # @param remark [ String ] 备注
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
        def shortcut_recharge_form(flow_id, contracts, money, return_url, notify_url, remark=nil)
          service = 'reapal.trust.depositApply'
          post_path = '/reagw/service/deposit.htm'

          params = {
            orderNo: flow_id,
            contracts: contracts,
            amount: money,
            returnUrl: return_url,
            notifyUrl: notify_url,
            busway: '01',
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          get_form_data(service, params, post_path, 3.0)
        end

    end
  end
end