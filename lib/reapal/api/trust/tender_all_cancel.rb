# coding: utf-8

module Reapal
  module Api
    module Trust
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
        #   * :result [String] "S"/"F"/"P"
        #   * :error_msg [String] 错误提示
        #   * :error_code [String] 融宝的错误编号
        #   * :data [Hash] 成功数据，返回的数据不一定是上送数据，
        #
        def tender_all_cancel(flow_id, tender_no, org_order_no, busway="01", remark)
          service = 'reapal.trust.tenderAllCancel'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: flow_id,
            tenderNo: tender_no,
            orgOrderNo: org_order_no,
            busway: busway,
            remark: '',
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          error_result = {
            data: nil,
            result: "F",
            error_msg: "未知错误",
          }

          # 如果数据不合法
          unless response.data_valid
            error_result[:error_msg] = "返回数据不合法"
            return error_result
          end

          # 如果网络出错，包括超时或者非200类数据
          unless response.http_response.kind_of?(Net::HTTPSuccess)
            error_result[:error_msg] = "网络出错"
            return error_result
          end

          # 只有返回码是 '0000'撤标才成功
          if ['0000',].include?(response.data[:resultCode])
            return {
              data: response.data,
              result: "S",
              error_msg: nil,
            }
          else
            # 富民server普通错误
            error_result[:error_code] = response.data[:errorCode]
            error_result[:error_msg] = response.data[:errorMsg]
            return error_result
          end
        end

      end # module TenderAllCancel
    end
  end
end
