# coding: utf-8

module Reapal
  module Api
    module User
      module MobileQuery

        # 1.4 手机号查询
        #
        # @param contract [ String ] 用户协议号
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #     * :contracts [String] 用户协议号
        #     * :mobile [String] 用户手机号
        #
        def mobile_query(contract)
          service = 'reapal.trust.mobileQuery'
          post_path = '/user/restApi.htm'

          params = {
            contracts: contract,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:query, service, params, post_path, Http::ErrorCode.mobile, ['0000'])

          Reapal.logger.info res

          res
        end

      end
    end
  end
end
