# coding: utf-8

module Reapal
  module Api
    module User
      module OnekeyBatchContract

        # 1.1 个人一键签约（API）新版本，迁移老数据
        #
        # @param flow_id [ String ] 订单号
        #
        # @return [ Hash ] 结果集
        #   * :result [String] "S"/"F"/"P"
        #   * :error_msg [String] 错误提示
        #   * :error_code [String] 融宝的错误编号
        #   * :data [Hash] 成功数据，返回的数据不一定是上送数据，比如手机号。所以要以返回数据为准
        #       * :contracts [String] 用户签约协议号
        #       * :userName [String] 姓名
        #       * :userIdentity [String] 身份证
        #       * :userMobile [String] 手机号
        #
        def onekey_batch_contract(flow_id, true_name, identity_id, phone, is_to_sms,
                                  bank_code, card_id, card_province, card_city, card_branch, card_sub_branch,
                                  bus_way='01')
          service = 'reapal.trust.onekeyBatchContract'
          post_path = '/reagw/agreement/agree.htm'

          params = {
            orderNo: flow_id,
            userName: true_name,
            userIdentity: identity_id,
            userMobile: phone,
            busway: bus_way,
            remark: '',
            isToSms: is_to_sms,
            bankCode: bank_code,
            bankAccountNo: card_id,
            accountProvince: card_province,
            accountCity: card_city,
            branch: card_branch,
            subbranch: card_sub_branch,
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

          # 个人签约只有返回码是 '0000', '0007' 才成功
          if ['0000', '0007'].include?(response.data[:resultCode])
            return {
              data: response.data,
              result: "S",
              error_msg: nil,
            }
          else
            # 普通错误
            error_result[:error_code] = response.data[:errorCode]
            error_result[:error_msg] = response.data[:errorMsg]
            return error_result
          end
        end

      end # module Agree
    end
  end
end
