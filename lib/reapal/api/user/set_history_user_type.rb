# coding: utf-8
module Reapal
  module Api
    module User
      module SetHistoryUserType

        # 5.1 设置历史用户角色
        #
        # @param flow_id [ String ] 订单号
        # @param contracts [ String ] 用户协议号
        # @param user_type [ String ] 注册类别 01：出借人 02：借款人 03：担保人 04：受托方
        #
        # @return [ Hash ] 结果集
        #   * :result [String] "S"/"F"/"P"
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #       * :flow_id [ String ]  订单号
        #       * :result_code [ String ] 结果代码 0000：设置成功
        #
        def set_history_user_type(flow_id, contracts, user_type)
          service = 'reapal.trust.setHistoryUserType'
          post_path = '/reagw/agreement/setHistoryUserType.htm'

          params = {
            orderNo: flow_id,
            contracts: contracts,
            userType: user_type,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.common, ['0000'])

          Reapal.logger.info res

          res
        end

      end # module
    end
  end
end
