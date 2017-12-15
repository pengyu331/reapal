# coding: utf-8

module Reapal
  module Api
    module Tender
      module TenderAuthQuery

        # 3.21  标的授权查询
        #
        # @param flow_id [String] 操作订单号
        # @param contracts [String] 用户协议号
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
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

          res = operate_post(:query, service, params, post_path, Http::ErrorCode.tender_auth_query, ['0000'])

          Reapal.logger.info res

          res
        end

      end # module TenderAuthQuery
    end
  end
end
