# coding: utf-8

module Reapal
  module Api
    module User
      module OnekeyComContract

        # 1.4 企业一键签约（API）
        #
        # @param flow_id [ String ] 订单号
        # @param corp_name [ String ] 法人代表姓名
        # @param identity_id [ String ] 法人身份证号
        # @param com_name [ String ] 企业名称
        # @param com_license [ String ] 组织机构代码/社会征信号
        # @param lic_start_date [ Time ] 企业组织机构证起始日
        # @param lic_end_date [ Time ] 企业组织机构证截止日
        # @param phone [ String ] 手机号
        # @param return_url [ String ] 回调 URL
        # @param notify_url [ String ] 通知 URL
        # @param email [ String ] 企业邮箱
        # @param busway [ String ] 设备通道，默认手机端 00：PC端；01：手机端；02：Pad端；03：其它
        # @param remark [ String ] 备注
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #     * :orderNo [String] 订单号
        #     * :contracts [String] 企业签约协议号
        #     * :resultCode [String] 结果代码 0000：申请成功 0002：签约成功（审核通过）0003：签约失败（审核不通过）0006：再次申请成功（拒绝后）
        #     * :corpName [String] 法人代表姓名
        #     * :corpIdentity [String] 法人身份证号
        #     * :comName [String] 企业名称
        #     * :comLicense [String] 组织机构代码/社会征信号
        #     * :licStartDate [String] 企业组织机构证起始日
        #     * :licEndDate [String] 企业组织机构证截止日
        #     * :mobile [String] 手机号
        #     * :email [String] 企业邮箱
        #     * :remark [String] 备注
        #
        def onekey_com_contract(flow_id, corp_name, identity_id, com_name, com_license,
                                lic_start_date, lic_end_date, phone, return_url, notify_url,
                                email, busway='01', remark='')
          service = 'reapal.trust.comContractAPI'
          post_path = '/reagw/agreement/agree.htm'

          params = {
            orderNo: flow_id,
            corpName: corp_name,
            corpIdentity: identity_id,
            comName: com_name,
            comLicense: com_license,
            licStartDate: lic_start_date.strftime("%Y%m%d"),
            licEndDate: lic_end_date.strftime("%Y%m%d"),
            mobile: phone,
            email: email,
            busway: busway,
            returnUrl: return_url,
            notifyUrl: notify_url,
            remark: '',
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.contract_create, ['0002', '0006'])

          if 'S' == res[:result] && '0003' == res[:data][:resultCode]
            res[:result] = 'F'
          end

          res
        end

      end # module
    end
  end
end
