# coding: utf-8

module Reapal
  module Api
    module Agreement
      module Agree

        # 个人一键签约（API）
        #
        # @param flow_id [ String ] 订单号
        # @param true_name [ String ] 真实姓名
        # @param identity_id [ String ] 身份证号
        # @param phone [ String ] 手机号
        # @param bus_way [ String ] 00：PC端；01：手机端；02：Pad端；03：其它
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
        def agree(flow_id, true_name, identity_id, phone, bus_way='01')
          service = 'reapal.trust.onekeyContract'
          post_path = '/reagw/agreement/agree.htm'

          params = {
            orderNo: flow_id,
            userName: true_name,
            userIdentity: identity_id,
            userMobile: phone,
            busway: bus_way,
            remark: '',
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
            error_result[:error_code] = response.data[:errorCode]
            error_result[:error_msg] = response.data[:errorMsg]
            return error_result
          end
        end

      end # module Agree
    end
  end
end
