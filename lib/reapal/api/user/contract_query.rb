# coding: utf-8

module Reapal
  module Api
    module User
      module ContractQuery

        # 1.5 签约查询，支持个人和企业（API）
        #
        # @param oneket_com_contract_flow_id [ String ] 签约订单号
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
        #     * :mobile [String] 手机号
        #     * :email [String] 企业邮箱
        #     * :remark [String] 备注
        #
        def contract_query(oneket_com_contract_flow_id)
          service = 'reapal.trust.contractQuery'
          post_path = '/reagw/agreement/agreeApi.htm'

          params = {
            orderNo: oneket_com_contract_flow_id,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          if Api::ErrorCode.contract_query.include?(response.data[:errorcode])
            res[:result] = 'F'
            return res
          end

          # 查询类 api，http 没成功都返回 pending
          return res unless response.http_success?

          # 如果查不到这个人
          if response.data[:errorCode] == '0113'
            res[:result] = 'F'
            return res
          end

          # 其余 api 错误不知道
          return res unless response.data[:errorCode].nil?

          res[:result] = 'S'

          res
        end

      end # module
    end
  end
end
