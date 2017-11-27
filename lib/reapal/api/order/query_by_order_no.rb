# coding: utf-8

module Reapal
  module Api
    module Order
      module QueryByOrderNo

        # 4.3  订单号查询（批量）
        #
        # @param order_no [String] 业务订单号【对应还款、债权转让、投标撤销、满标操作订单号】
        # @param service_no [String] 查询类型: '01':投标撤销查询，'02':满标查询，'03':还款查询，'04':债权转让查询查询

        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #      * :orderNo [String] 商户订单号
        #      * :resultCode [String] 结果代码
        #      * :failDetails [String] 失败明细
        #          * :seriaNo [String] 业务流水号
        #          * :errorCode [String] 错误代码
        #          * :errorMsg [String]  错误信息
        #

        def query_by_order_no(order_no, service_no)
          service_tender_cancel = 'reapal.trust.tenderCancelMQuery'  #投标撤销查询，
          service_tender_finish = 'reapal.trust.tenderFinishMQuery'  #满标查询，
          service_tender_refund = 'reapal.trust.tenderRefundMQuery'  #还款查询，
          service_tender_transfer = 'reapal.trust.tenderTransferMQuery'  #债权转让查询

          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: order_no,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          if '01' == service_no
            service = service_tender_cancel
          elsif '02' == service_no
            service = service_tender_finish
          elsif '03' == service_no
            service = service_tender_refund
          elsif '04' == service_no
            service = service_tender_transfer
          else
            res[:result] = "F"
            res[:error_msg] = "参数service_no错误"
            return res
          end

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          #查询类 api，http 没成功都返回 pending
          return res if response.http_success?

          #确定的错误
          if Reapal::Api::ErrorCode.query_by_order_no.include?(response.data[:resultCode])
            res[:result] = "F"
            return res
          end

          # 其余 api 错误不知道,pending
          return res unless response.data[:errorCode].nil?


          # 只有返回码是 '0000' 查询信息成功
          if ['0000'].include?(response.data[:resultCode])
            res[:result] = "S"
          end

          res
        end

      end # module QueryByOrderNo
    end
  end
end
