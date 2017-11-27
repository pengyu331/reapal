# coding: utf-8

module Reapal
  module Api
    module User
      module BankCardAddSmsConfirm

        # 1.11 一键绑卡确认（API）
        #
        # @param flow_id [ String ] 交易订单号（与一键绑卡申请订单号保持一致）
        # @param check_code [ String ] 短信验证码
        # @param busway [ String ] 设备通道 00：PC端；01：手机端；02：Pad端；03：其它
        # @param remark [ String ] 业务备注信息

        # @return [ Hash ] 结果集
        #   * :result [String] "S"/"F"/"P"
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #       * :flow_id [ String ] 交易订单号
        #       * :result_code [ String ] 结果代码 0000：绑卡成功
        #
        def bank_card_add_sms_confirm(flow_id, check_code = '123456', busway = '01', remark = "")
          service = 'reapal.trust.bankCardAddSMSConfirm'
          post_path = '/reagw/bankcard/bankCardSMS.htm'

          params = {
            orderNo: flow_id,
            checkCode: check_code,
            busway: busway,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          operate_post(:operate, service, params, post_path, Http::ErrorCode.bind_card, ['0000'])
        end

      end # module
    end
  end
end
