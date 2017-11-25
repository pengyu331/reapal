# coding: utf-8

module Reapal
  module Api
    module Asset
      module TenderRepaymentComplete

        # 3.15 还款计划更新（API）
        #
        # @param flow_id [String] 执行还款计划订单号
        # @param tender_no [String] 商户系统标的号
        # @param periods [String] 还款期数
        # @param comp_principal [BigDecimal] 执行还款本金
        # @param comp_interest [BigDecimal] 执行还款利息
        # @param comp_poundage [BigDecimal] 执行还款手续费
        # @param comp_amount [BigDecimal] 执行还款总金额
        # @param comp_time [String] 执行还款日期
        # @param busway [String] 设备通道， '00'：PC端；'01'：手机端(默认)；'02'：Pad端；'03'：其它
        # @param remark [String] 备注

        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #      * :orderNo [String] 执行还款订单号
        #      * :resultCode [String] 结果代码
        #
        def tender_repayment_complete(flow_id, tender_no, periods, comp_principal, comp_interest,
                               comp_poundage, comp_amount, comp_time, busway='01', remark='')
          service = 'reapal.trust.repaymentComplete'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: flow_id,
            tenderNo: tender_no,
            periods: periods,
            compPrincipal: comp_principal,
            compInterest: comp_interest,
            compPoundage: comp_poundage,
            compAmount: comp_amount,
            compTime: comp_time,
            busway: busway,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          #非返回类错误
          return res if response.http_pending? # 比如超时等操作

          # 只有返回码是 '0000'还款信息同步成功
          if ['0000'].include?(response.data[:resultCode])
            res[:result] = "S"
          end

          #确定的错误
          if Reapal::Api::ErrorCode.tender_repayment_complete.include?(response.data[:resultCode])
            res[:result] = "F"
            return res
          end

          # 不能确定的错误 ，pending
          res
        end

      end # module TenderRepaymentComplete
    end
  end
end
