# coding: utf-8

module Reapal
 module Api
   module Money
     module DepositConfirmApi

       # 2.3 快捷充值确认（API）
       #
       # @param flow_id [ String ] 商户订单号（非自动生成，与充值签约订单号一致）
       # @param contracts [ String ] 用户协议号
       # @param check_code [ String ] 短信验证码
       # @param terminal_info [ String ] 终端信息（手机IMEI地址、MAC地址、UUID）
       # @param member_ip [ String ] 用户IP
       # @param busway [ String ] 设备通道 00：PC端；01：手机端；02：Pad端；03：其它
       # @param remark [ String ] 业务备注信息
       #
       # @return [ Hash ] 结果集
       #   * :result [String] "S"/"F"/"P"
       #   * :request_params [Hash] 请求参数
       #   * :response [Object] 请求返回对象
       #   * :error_code [String] 错误代号
       #   * :error_msg [String] 错误信息
       #   * :data: 具体业务返回信息
       #       * :orderNo [String]  订单号
       #       * :resultCode [String] 结果代码 0000：充值成功
       #       * :resultMsg [String] 结果描述
       #
       def deposit_confirm_api(flow_id, contracts, check_code, terminal_info, member_ip, busway = '01', remark = '')
         service = 'reapal.trust.depositConfirmAPI'
         post_path = '/reagw/service/depwit.htm'

         params = {
           orderNo: flow_id,
           contracts: contracts,
           checkCode: check_code,
           busway: busway,
           terminalInfo: terminal_info,
           memberIp: member_ip,
           applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
         }

         res = operate_post(:operate, service, params, post_path, Http::ErrorCode.deposit_confirm_api, ['0000'])

         error_result_code = %w(9060 9065 9083 9084 9085 0017 0210 0302 0303 0328 0329
                                0330 0332 0333 0335 0339 0340 0341 0342 0343 0344 0345
                                0346 0347 0348 0350 0351 0352 0358 0359 0360 0362 0363
                                0001 0004)

         if 'S' == res[:result] && error_result_code.include?(res[:data][:resultCode])
           res[:result] = 'F'
         end

         res
       end

     end # module
   end
  end
end
