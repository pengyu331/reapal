module Reapal
  module Form
    module ComUpdateInfoForm

        # 1.3 企业信息修改
        #
        # @param flow_id [ String ] 订单号
        # @param contract [ String ] 协议号
        # @param return_url [ String ] 回调 URL
        # @param notify_url [ String ] 通知 URL
        # @param busway [ String ] 设备通道，默认手机端 00：PC端；01：移动端H5页面
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
        def com_update_info_form(flow_id, contract, return_url, notify_url,
                                 busway='01', remark='')
          service = 'reapal.trust.comUpadteInfo'
          post_path = '/agreement/agree.htm'

          params = {
            orderNo: flow_id,
            contracts: contract,
            busway: busway,
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