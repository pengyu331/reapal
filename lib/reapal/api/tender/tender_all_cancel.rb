# coding: utf-8

module Reapal
  module Api
    module Tender
      module TenderAllCancel

        # 3.7 撤标
        #
        # @param flow_id [String] 撤标订单号
        # @param tender_no [String] 商户系统标的号
        # @param original_flow_id [String] 原来投标时订单号
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
        #     * :orderNo [String] 撤销订单号
        #     * :resultCode [String] 结果代码
        #
        def tender_all_cancel(flow_id, tender_no, original_flow_id, busway="01", remark='')
          service = 'reapal.trust.tenderAllCancel'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: flow_id,
            tenderNo: tender_no,
            orgOrderNo: original_flow_id,
            busway: busway,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          operate_post(:operate, service, params, post_path, Http::ErrorCode.tender_cancel, ['0000'])
        end

      end # module TenderAllCancel
    end
  end
end
