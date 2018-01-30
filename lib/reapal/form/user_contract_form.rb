module Reapal
  module Form
    module UserContractForm

        # 1.1 个人签约
        #
        # @param flow_id [ String ] 订单号
        # @param true_name [ String ] 真实姓名
        # @param identity_id [ String ] 身份证号
        # @param user_type [ String ] 01：出借人 02：借款人 03：担保人 04：受托方
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
        def user_contract_form(flow_id, true_name, identity_id, user_type, return_url, notify_url, bus_way='01', remark='')
          service = 'reapal.trust.userContract'
          post_path = '/reagw/agreement/agree.htm'

          params = {
            orderNo: flow_id,
            userName: true_name,
            userIdentity: identity_id,
            userType: user_type,
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