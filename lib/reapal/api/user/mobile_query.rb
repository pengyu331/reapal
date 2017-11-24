# coding: utf-8

module Reapal
  module Api
    module User
      module MobileQuery

        # 1.8 手机号查询
        #
        # @param contracts [ String ] 用户协议号
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


        def mobile_query(contracts)
          service = 'reapal.trust.mobileQuery'
          post_path = '/reagw/user/restApi.htm'

          params = {
            contracts: contracts,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          if Api::ErrorCode.mobile.include?(response.data[:errorcode])
            res[:result] = 'F'
            return res
          end

          # 查询类 api，http 没成功都返回 pending
          return res unless response.http_success?

          # 其余 api 错误不知道
          return res unless response.data[:errorCode].nil?

          res[:result] = "S"

          res
        end

      end
    end
  end
end
