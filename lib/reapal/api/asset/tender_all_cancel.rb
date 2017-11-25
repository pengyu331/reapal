# coding: utf-8

module Reapal
  module Api
    module Asset
      module TenderAllCancel

        # 3.7 撤标
        #
        # @param flow_id [String] 撤标订单号
        # @param tender_no [String] 商户系统标的号
        # @param org_order_no [String] 原来投标时订单号
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
        def tender_all_cancel(flow_id, tender_no, org_order_no, busway="01", remark='')
          service = 'reapal.trust.tenderAllCancel'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: flow_id,
            tenderNo: tender_no,
            orgOrderNo: org_order_no,
            busway: busway,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          return res if response.http_pending? # 比如超时等操作

          if Reapal::Api::ErrorCode.tender_cancel.include?(response.data[:resultCode])
            res[:result] = "F"
            return res
          end

          # 只有返回码是 '0000'撤标才成功
          if ['0000'].include?(response.data[:resultCode])
            res[:result] = "S"
            return res
          end

          # 不能确定的错误 ，pending
          res

        end

      end # module TenderAllCancel
    end
  end
end
