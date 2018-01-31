module Reapal
  module Form
    module TenderApplyConfirmForm

        # 3.2 发标确认
        #
        # @param flow_id [ String ] 订单号
        # @param tender_no [ String ] 标的号
        # @param return_url [String] 回调 url
        # @param notify_url [String] 通知 url
        # @param bus_way [ String ] 00：PC端；01：手机端；02：Pad端；03：其它
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
        def tender_apply_confirm_form(flow_id, tender_no, return_url, notify_url, bus_way='01', remark=nil)
          service = 'reapal.trust.tenderApplyConfirm'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: flow_id,
            tenderNo: tender_no,
            returnUrl: return_url,
            notifyUrl: notify_url,
            busway: bus_way,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          get_form_data(service, params, post_path)
        end

    end
  end
end