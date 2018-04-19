module Reapal
  module Form
    module ComUploadingInfoForm

        # 5.4 企业迁移用户激活
        #
        # @param flow_id [ String ] 订单号
        # @param contract [ String ] 协议号
        # @param return_url [ String ] 回调 URL
        # @param notify_url [ String ] 通知 URL
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
        def com_uploading_info_form(flow_id, contract, return_url, notify_url, remark='')
          service = 'reapal.trust.comUploadingInfo'
          post_path = '/agreement/agree.htm'

          params = {
            orderNo: flow_id,
            contracts: contract,
            returnUrl: return_url,
            notifyUrl: notify_url,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          get_form_data(service, params, post_path)
        end

    end
  end
end