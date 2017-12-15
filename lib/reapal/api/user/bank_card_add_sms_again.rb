# coding: utf-8

module Reapal
  module Api
    module User
      module BankCardAddSmsAgain

        # 1.11 一键绑卡重发短信（API）
        #
        # @param flow_id [ String ] 交易订单号（非自动生成，与一键绑卡申请短信订单号保持一致）
        # @param contracts [ String ] 用户协议号
        # @param busway [ String ] 设备通道 00：PC端；01：手机端；02：Pad端；03：其它
        # @param remark [ String ] 业务备注信息
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #      * :flow_id [ String ] 交易订单号
        #      * :result_code [ String ] 结果代码 0000：绑卡成功
        #
        def bank_card_add_sms_again(flow_id, contracts, busway = '01', remark = "")
          service = 'reapal.trust.bankCardAddSMSAgain'
          post_path = '/reagw/bankcard/bankCardSMS.htm'

          params = {
            orderNo: flow_id,
            contracts: contracts,
            busway: busway,
            remark: remark,
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
