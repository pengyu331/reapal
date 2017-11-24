# coding: utf-8

module Reapal
  module Api
    module Asset
      module TenderAuthQuery

        # 3.21  标的授权查询
        #
        # @param flow_id [String] 操作订单号
        # @param contracts [String] 用户协议号


        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #     * :orderNo [String] 操作订单号
        #     * :contracts [String] 用户协议号
        #     * :servicesDetail [JSON] 授权明细
        #        * :services [String] 授权服务。 02一键投标 ，03 为一键还款 04 一键债转
        #        * :authLimit [String] 授权期限日期 YYYYMMDD
        #        * :terderNo [String] 标的号

        def tender_auth_query(flow_id, contracts)
          service = 'reapal.trust.authQuery'
          post_path = '/reagw/user/restApi.htm'

          params = {
            orderNo: flow_id,
            contracts: contracts,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          #查询类 api，http 没成功都返回 pending
          return res if response.http_success?

          #确定的错误
          if Reapal::Api::ErrorCode.tender_auth_query.include?(response.data[:resultCode])
            res[:result] = "F"
            return res
          end


          # 其余 api 错误不知道
          return res unless response.data[:errorCode].nil?

          #查询成功
          res[:result] = "S"

          res
        end

      end # module TenderAuthQuery
    end
  end
end
