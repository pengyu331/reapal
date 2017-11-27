# coding: utf-8

module Reapal
  module Api
    module Asset
      module TenderRepaymentProject

        # 3.14 还款计划
        #
        # @param flow_id [String] 还款计划订单号
        # @param tender_no [String] 商户系统标的号
        # @param project_details [hash] 还款计划明细
        #   * :periods [Integer] 还款期数
        #   * :proj_principal [BigDecimal] 计划还款本金
        #   * :proj_interest [BigDecimal] 计划还款利息
        #   * :proj_poundage [BigDecimal] 计划还款手续费
        #   * :proj_amount [BigDecimal] 计划还款总金额
        #   * :proj_time [String] 计划还款日期
        # @param busway [String] 设备通道， '00'：PC端；'01'：手机端(默认)；'02'：Pad端；'03'：其它
        # @param remark [String] 备注

        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #      * :orderNo [String] 还款订单号
        #      * :resultCode [String] 结果代码
        #
        def tender_repayment_project(flow_id, tender_no, project_details, busway='01', remark='')
          service = 'reapal.trust.repaymentProject'
          post_path = '/reagw/tender/rest.htm'

          # project_detail = {}
          # project_detail[:periods] = project_details[:periods]
          # project_detail[:projPrincipal] = project_details[:proj_principal]
          # project_detail[:projInterest] = project_details[:proj_interest]
          # project_detail[:projPoundage] = project_details[:proj_poundage]
          # project_detail[:projAmount] = project_details[:proj_amount]
          # project_detail[:projTime] = project_details[:proj_time]

          params = {
            orderNo: flow_id,
            tenderNo: tender_no,
            projectDetails: project_details.to_json,
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
          if Reapal::Api::ErrorCode.tender_repayment_project.include?(response.data[:resultCode])
            res[:result] = "F"
            return res
          end

          # 不能确定的错误 ，pending
          res
        end

      end # module TenderRepaymentProject
    end
  end
end
