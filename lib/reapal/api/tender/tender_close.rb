# coding: utf-8

module Reapal
  module Api
    module Tender
      module TenderClose

        # 3.18 标的关闭
        #
        # @param tender_no [String] 标的号
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
        #     * :resultCode [String] 结果代码 0000：关闭成功
        #
        def tender_close(tender_no, busway="01", remark='')
          service = 'reapal.trust.tenderClose'
          post_path = '/tender/rest.htm'

          params = {
            tenderNo: tender_no,
            busway: busway,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.tender_close, ['0000'])

          Reapal.logger.info res

          res
        end

      end # module
    end
  end
end
