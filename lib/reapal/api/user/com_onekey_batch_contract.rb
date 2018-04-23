# coding: utf-8

module Reapal
  module Api
    module User
      module ComOnekeyBatchContract

        # 5.3 历史企业用户迁移
        #
        # @param flow_id [ String ] 订单号
        # @param corp_name [ String ] 法人代表姓名
        # @param corp_identity [ String ] 法人代表身份证号
        # @param corp_phone [ String ] 法人代表手机号
        # @param manager_name [ String ] 经办人姓名
        # @param manager_identity [ String ] 经办人身份证号
        # @param manager_phone [ String ] 经办人身份证号
        # @param com_name [ String ] 企业名称
        # @param com_license [ String ] 企业组织机构代码/社会征信号
        # @param lic_start_date [ Time ] 企业组织机构证起始日
        # @param lic_end_date [ Time ] 企业组织机构证截止日
        # @param bank_code [ String ] 银行代码
        # @param card_id [ String ] 企业对公账户号
        # @param user_type [ String ] 注册类别 01：出借人 02：借款人 03：担保人 04：受托方
        # @param email [ String ] 企业邮箱
        # @param busway [ String ] 设备通道 00：PC端
        # @param remark [ String ] 备注
        #
        # @return [ Hash ] 结果集
        #   * :result [String] "S"/"F"/"P"
        #   * :error_msg [String] 错误提示
        #   * :error_code [String] 融宝的错误编号
        #   * :data [Hash] 成功数据，返回的数据不一定是上送数据，比如手机号。所以要以返回数据为准
        #       * :orderNo: [String] 签约订单号
        #       * :contracts [String] 企业签约协议号
        #       * :resultCode [String] 结果代码 0000：申请成功
        #       * :corpName [String] 法人代表姓名
        #       * :corpIdentity [String] 法人代表身份证号
        #       * :corpMobile [String] 法人代表手机号
        #       * :managerNmae [String] 经办人姓名
        #       * :managerIdentity [String] 经办人身份证号
        #       * :managerMobile [String] 经办人手机号
        #       * :comName [String] 企业名称
        #       * :comLicense [String] 企业组织机构/社会征信号
        #       * :licStartDate [String] 企业组织机构证起始日
        #       * :licEndDate [String] 企业组织机构证截止日
        #       * :bankAccountNo [String] 银行卡后四位
        #       * :bankCode [String] 银行编码
        #       * :userType [String] 注册类别
        #       * :email [String] 企业邮箱
        #       * :remark [String] 备注
        #       * :processTime [String] 处理时间
        #
        def com_onekey_batch_contract(flow_id, corp_name, corp_identity, corp_phone, manager_name,
                                      manager_identity, manager_phone, com_name, com_license, lic_start_date,
                                      lic_end_date, bank_code, card_id, user_type, email,
                                      return_url, notify_url, busway='00',remark='')
          service = 'reapal.trust.oneKeyBatchCompInformationTransfer'
          post_path = '/agreement/agree.htm'

          params = {
            orderNo: flow_id,
            corpName: corp_name,
            corpIdentity: corp_identity,
            corpMobile: corp_phone,
            managerName: manager_name,
            managerIdentity: manager_identity,
            managerMobile: manager_phone,
            comName: com_name,
            comLicense: com_license,
            licStartDate: lic_start_date.strftime('%Y%m%d'),
            licEndDate: lic_end_date.strftime('%Y%m%d'),
            busway: busway,
            remark: remark,
            bankCode: bank_code,
            bankAccountNo: card_id,
            userType: user_type,
            email: email,
            returnUrl: return_url,
            notifyUrl: notify_url,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.contract_create, ['0000', '0007'])

          Reapal.logger.info res

          res
        end

      end # module Agree
    end
  end
end
