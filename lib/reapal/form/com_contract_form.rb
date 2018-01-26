module Reapal
  module Form
    module ComContractForm

        # 1.1 企业签约
        #
        # @param flow_id [ String ] 订单号
        # @param corp_name [ String ] 法人代表姓名
        # @param identity_id [ String ] 法人身份证号
        # @param com_name [ String ] 企业名称
        # @param com_license [ String ] 组织机构代码/社会征信号
        # @param lic_start_date [ Time ] 企业组织机构证起始日
        # @param lic_end_date [ Time ] 企业组织机构证截止日
        # @param phone [ String ] 手机号
        # @param bank_code [ String ] 银行编码
        # @param user_type [ String ] 注册类别 01：出借人 02：借款人 03：担保人 04：受托方
        # @param email [ String ] 企业邮箱
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
        def com_contract_form(flow_id, corp_name, identity_id, com_name, com_license,
                               lic_start_date, lic_end_date, phone, bank_code,
                               user_type, email, return_url, notify_url,
                               busway='01', remark='')

          service = 'reapal.trust.comContract'
          post_path = '/reagw/agreement/agree.htm'

          params = {
            orderNo: flow_id,
            corpName: corp_name,
            corpIdentity: identity_id,
            comName: com_name,
            comLicense: com_license,
            licStartDate: lic_start_date.strftime("%Y%m%d"),
            licEndDate: lic_end_date.strftime("%Y%m%d"),
            bankMobile: phone,
            bankCode: bank_code,
            userType: user_type,
            email: email,
            busway: busway,
            returnUrl: return_url,
            notifyUrl: notify_url,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          get_form_data(service, params, post_path, '3.0')
        end

    end
  end
end