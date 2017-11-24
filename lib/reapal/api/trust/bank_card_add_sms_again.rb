# coding: utf-8

module Reapal
  module Api
    module Trust
      module BankCardAddSmsAgain

        # 1.11 一键绑卡重发短信（API）
        #
        # @param order_no [ String ] 交易订单号（非自动生成，与一键绑卡申请短信订单号保持一致）
        # @param contracts [ String ] 用户协议号
        # @param busway [ String ] 设备通道 00：PC端；01：手机端；02：Pad端；03：其它
        # @param remark [ String ] 业务备注信息
        #
        # @return [ Hash ] 结果集
        #   * :order_no [ String ] 交易订单号
        #   * :result_code [ String ] 结果代码 0000：绑卡成功
        #
        def bank_card_add_sms_again(order_no, contracts, busway = '01', remark = "")
          service = 'reapal.trust.bankCardAddSMSAgain'
          post_path = '/reagw/bankcard/bankCardSMS.htm'

          params = {
            orderNo: order_no,
            contracts: contracts,
            busway: busway,
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
