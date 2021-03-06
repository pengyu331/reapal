# coding: utf-8

module Reapal
  module Api
    module User
      module OnekeyContract

        # 1.2 个人一键签约（API）
        #
        # @param flow_id [ String ] 订单号
        # @param true_name [ String ] 真实姓名
        # @param identity_id [ String ] 身份证号
        # @param phone [ String ] 手机号
        # @param bus_way [ String ] 00：PC端；01：手机端；02：Pad端；03：其它
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #     * :contracts [String] 用户签约协议号
        #     * :userName [String] 姓名
        #     * :userIdentity [String] 身份证
        #     * :userMobile [String] 手机号
        #
        def onekey_contract(flow_id, true_name, identity_id, phone, bus_way='01')
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

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.contract_create, ['0000', '0007'])

          Reapal.logger.info res

          res
        end

      end # module
    end
  end
end
