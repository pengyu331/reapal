# coding: utf-8

module Reapal
  module Api
    module Tender
      module TenderAuthCancel

        # 3.22 标的授权取消API
        #
        # @param flow_id [String] 订单号
        # @param contracts [ String ] 用户协议号
        # @param services [String] 授权业务。 02 自动投标 03 自动还款 05 自动担保还款
        # @param busway [String] 设备通道， '00'：PC端；'01'：手机端(默认)；'02'：Pad端；'03'：其它
        # @param remark [String] 备注
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #     * :services [String] 授权业务。 02一键投标 ，03 为一键还款 04 一键债转
        #     * :resultCode [String] 结果代码
        #
        def tender_auth_cancel(flow_id, contracts, services, busway="01", remark='')
          service = 'reapal.trust.authCancel'
          post_path = '/reagw/user/restApi.htm'

          params = {
            cancleOrderNo: flow_id,
            contracts: contracts,
            services: services,
            busway: busway,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.tender_auth_cancel, ['0000'], '3.0')

          Reapal.logger.info res

          res
        end

      end # module TenderAuthCancel
    end
  end
end
