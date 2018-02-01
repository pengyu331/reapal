# coding: utf-8
module Reapal
  module Api
    module User
      module ModifyBindBankCard

        # 1.9 修改绑卡（API）
        #
        # @param flow_id [ String ] 订单号
        # @param contracts [ String ] 用户协议号
        # @param bank_account_no [ String ] 银行卡账号后四位
        # @param account_province [ String ] 银行所在省
        # @param account_city [ String ] 银行所在市
        # @param branch [ String] 银行分行
        # @param subbranch [ String ] 银行支行
        #
        # @return [ Hash ] 结果集
        #   * :result [String] "S"/"F"/"P"
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #       * :flow_id [ String ]  订单号
        #       * :result_code [ String ] 结果代码 0000：申请成功
        #
        def modify_bind_bank_card(flow_id,
                                  contracts,
                                  bank_account_no,
                                  account_province,
                                  account_city,
                                  branch,
                                  subbranch)
          service = 'reapal.trust.modifyBindBankCard'
          post_path = '/reagw/bankcard/modifyBindBankApi.htm'

          params = {
            orderNo: flow_id,
            contracts: contracts,
            bankAccountNo: bank_account_no,
            accountProvince: account_province,
            accountCity: account_city,
            branch: branch,
            subbranch: subbranch,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.bind_card, ['0000'])

          Reapal.logger.info res

          res
        end

      end # module
    end
  end
end
