# coding: utf-8

module Reapal
  module Api
    module Order
      module QueryBySingleOrderNo

        # 4.2  订单号查询（单笔）
        #
        # @param order_no [String] 业务订单号【对应发标、投标订单号】
        # @param service_no [String] 查询类型: '01':发标单笔查询，'02':投标单笔查询

        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #      * :orderNo [String] 商户订单号
        #      * :realAmount [String] 实际投标金额(只针对投标查询)
        #      * :resultCode [String] 结果代码
        #

        def query_by_single_order_no(order_no, service_no)
          service_tender_apply = 'reapal.trust.tenderApplySQuery'  #发标查询
          service_tender_invest = 'reapal.trust.tenderInvestSQuery'  #投标查询
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: order_no,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          if '01' == service_no
            service = service_tender_apply
          elsif '02' == service_no
            service = service_tender_invest
          else
            res[:result] = "F"
            res[:error_msg] = "缺少参数service_no"
            return res
          end

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          #查询类 api，http 没成功都返回 pending
          return res if response.http_success?

          #确定的错误
          if Reapal::Api::ErrorCode.query_by_single_order_no.include?(response.data[:resultCode])
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

      end # module QueryBySingleOrderNo
    end
  end
end
