module Reapal
  module Api
    module User
      module BankCardAddSms

        # 1.10 一键绑卡申请（API）
        #
        # @param order_no [ String ] 订单号
        # @param contracts [ String ] 用户协议号
        # @param bank_code [ String ] 银行代码
        # @param bank_account_no [ String ] 银行卡账号
        # @param account_province [ String ] 银行所在省
        # @param account_city [ String ] 银行所在市
        # @param branch [ String] 银行分行
        # @param subbranch [ String ] 银行支行
        # @param mobile_phone [ String ] 银行预留手机

        # @return [ Hash ] 结果集
        #   * :result [String] "S"/"F"/"P"
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #       * :order_no [ String ]  订单号
        #       * :result_code [ String ] 结果代码 0000：申请成功
        #
        def bank_card_add_sms(order_no, contracts, bank_code, bank_account_no, account_province, account_city, branch, subbranch, mobile_phone)
          service = 'reapal.trust.bankCardAddSMS'
          post_path = '/reagw/bankcard/bankCardSMS.htm'

          params = {
            orderNo: order_no,
            contracts: contracts,
            bankCode: bank_code,
            bankAccountNo: bank_account_no,
            accountProvince: account_province,
            accountCity: account_city,
            branch: branch,
            subbranch: subbranch,
            mobilePhone: mobile_phone,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          return res if response.http_pending? # 比如超时等操作

          # 1，明确失败的
          if Api::ErrorCode.bind_card.include?(response.data[:errorCode])
            res[:result] = 'F'
            return res
          end

          # 2. 明确正确的
          if ['0000'].include?(response.data[:resultCode])
            res[:result] = 'S'
            return res
          end

          # 3. 其他错误 pending
          res

        end

      end # module
    end
  end
end
