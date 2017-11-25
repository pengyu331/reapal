module Reapal
  module Api
    module Trust
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
        #   * :error_msg [String] 错误提示
        #   * :data [Hash] 成功数据
        #       * :order_no [ String ]  订单号
        #       * :result_code [ String ] 结果代码
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

          error_result = {
            data: nil,
            result: "F",
            error_msg: "未知错误",
          }

          # 如果数据不合法
          unless response.data_valid
            error_result[:error_msg] = "返回数据不合法"
            return error_result
          end

          # 如果网络出错，包括超时或者非200类数据
          unless response.http_response.kind_of?(Net::HTTPSuccess)
            error_result[:error_msg] = "网络出错"
            return error_result
          end

          # 一键绑卡只有返回码是 '0000'才成功
          if ['0000'].include?(response.data[:resultCode])
            return {
              data: response.data,
              result: "S",
              error_msg: nil,
            }
          else
            error_result[:error_code] = response.data[:errorCode]
            error_result[:error_msg] = response.data[:errorMsg]
            return error_result
          end

        end

      end
    end
  end
end
