# coding: utf-8

module Reapal
  module Api
    module User
      module ContractQuery

        # 1.1.4 签约查询，支持个人和企业（API）
        #
        # @param contract_flow_id [ String ] 签约订单号
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #     * :orderNo [String] 签约订单号
        #     * :contract [String] 企业协议号
        #     * :result [String] * :resultCode [String] 结果代码 0000：签约成功 0003：待审核
        #     * :corpName [String] 法人代表姓名
        #     * :corpIdentity [String] 法人身份证号
        #     * :comLicense [String] 组织机构代码/社会征信号
        #     * :licStartDate [String] 企业组织机构证起始日
        #     * :licEndDate [String] 企业组织机构证截止日
        #     * :bankAccountNo [String] 银行卡后四位
        #     * :bankCode [String] 银行编码
        #     * :userType [String] 注册类别 01：出借人 02：借款人 03：担保人 04：受托方
        #     * :bankMobile [String] 手机号
        #     * :email [String] 企业邮箱
        #     * :remark [String] 备注
        #
        def contract_query(contract_flow_id)
          service = 'reapal.trust.contractQuery'
          post_path = '/agreement/agreeApi.htm'

          params = {
            orderNo: contract_flow_id,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:query, service, params, post_path, Http::ErrorCode.contract_query, ['0000'])

          if 'P' == res[:result] && '0001' == res[:data][:resultCode]
            res[:result] = 'F'
          end

          Reapal.logger.info res

          res
        end

      end # module
    end
  end
end
