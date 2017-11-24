# coding: utf-8

module Reapal
  module Api
    module Trust
      module DepositSmsApi

        # 2.4 快捷充值重发短信（API）
        #
        # @param order_no [ String ] 订单号（非自动生成，与充值签约订单号保持一致）
        # @param contracts [ String ] 用户协议号
        # @param busway [ String ] 设备通道 00：PC端；01：手机端；02：Pad端；03：其它
        # @param terminal_info [ String ] 终端信息（手机IMEI地址、MAC地址、UUID）
        # @param member_ip [ String ] 用户IP
        # @param remark [ String ] 业务备注信息
        #
        # @return [ Hash ] 结果集
        #   * :result [String] "S"/"F"/"P"
        #   * :error_msg [String] 错误提示
        #   * :data [Hash] 成功数据
        #       * :orderNo [String]  订单号
        #       * :resultCode [String] 结果代码 0000：发送成功
        #       * :resultMsg [String] 结果描述
        #
        def deposit_sms_api(order_no, contracts, busway = '01', terminal_info, member_ip, remark = "")
          service = 'reapal.trust.depositSmsAPI'
          post_path = '/reagw/service/depwit.htm'

          params = {
            orderNo: order_no,
            contracts: contracts,
            busway: busway,
            terminalInfo: terminal_info,
            memberIp: member_ip,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          error_result = {
            data: nil,
            result: "F",
            error_msg: "未知错误",
          }

          unless response.data_valid
            error_result[:error_msg] = "返回数据不合法"
            return error_result
          end

          # 如果网络出错，包括超时或者非200类数据
          unless response.http_response.kind_of?(Net::HTTPSuccess)
            error_result[:error_msg] = "网络出错"
            return error_result
          end

          # 一键绑卡重发短信只有返回码是 '0000' 才成功
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
