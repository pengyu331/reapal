# coding: utf-8

module Reapal
  module Api
    module Money
      module DepositSmsApi

        # 2.4 快捷充值重发短信（API）
        #
        # @param flow_id [ String ] 订单号（非自动生成，与充值签约订单号保持一致）
        # @param contracts [ String ] 用户协议号
        # @param busway [ String ] 设备通道 00：PC端；01：手机端；02：Pad端；03：其它
        # @param terminal_info [ String ] 终端信息（手机IMEI地址、MAC地址、UUID）
        # @param member_ip [ String ] 用户IP
        # @param remark [ String ] 业务备注信息
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #       * :orderNo [String]  订单号
        #       * :resultCode [String] 结果代码 0000：发送成功
        #       * :resultMsg [String] 结果描述
        #
        def deposit_sms_api(flow_id, contracts, terminal_info, member_ip, busway = '01', remark = "")
          service = 'reapal.trust.depositSmsAPI'
          post_path = '/reagw/service/depwit.htm'

          params = {
            orderNo: flow_id,
            contracts: contracts,
            busway: busway,
            terminalInfo: terminal_info,
            memberIp: member_ip,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.deposit_sms_api, ['0000'])

          Reapal.logger.info res

          res
        end

      end # module
    end
  end
end
