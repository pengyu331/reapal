module Reapal
  module Form
    module TenderInvestForm

        # 3.4 投标
        #
        # @param flow_id [ String ] 订单号
        # @param tender_no [ String ] 标的号
        # @param amount [ Number ] 金额
        # @param invest_contract [ String ] 投资方协议号
        # @param return_url [String] 回调 url
        # @param notify_url [String] 通知 url
        # @param coupon_amt [ Number ] 红包抵用券
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
        def tender_apply_confirm_form(flow_id, tender_no,
                                      amount, invest_contract,
                                      return_url, notify_url,
                                      coupon_amt=nil, remark=nil)
          service = 'reapal.trust.tenderApplyConfirm'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: flow_id,
            tenderNo: tender_no,
            amount: amount,
            investContracts: invest_contract,
            returnUrl: return_url,
            notifyUrl: notify_url,
            busway: '00',
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          get_form_data(service, params, post_path)
        end

    end
  end
end