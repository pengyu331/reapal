# coding: utf-8

module Reapal
  module Api
    module Trust
      module BankCardAddSmsConfirm

        # 1.11 一键绑卡确认（API）
        #
        # @param order_no [ String ] 交易订单号（与一键绑卡申请订单号保持一致）
        # @param check_code [ String ] 短信验证码
        # @param busway [ String ] 设备通道 00：PC端；01：手机端；02：Pad端；03：其它
        # @param remark [ String ] 业务备注信息

        # @return [ Hash ] 结果集
        #   * :order_no [ String ] 交易订单号
        #   * :result_code [ String ] 结果代码 0000：绑卡成功
        #
        def bank_card_add_sms_confirm(order_no, check_code = '123456', busway = '01', remark = "")
          service = 'reapal.trust.bankCardAddSMSConfirm'
          post_path = '/reagw/bankcard/bankCardSMS.htm'

          params = {
            orderNo: order_no,
            checkCode: check_code,
            busway: busway,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          error_result = {
            data: nil,
            result: "F",
            error_msg: "未知错误",
          }

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
