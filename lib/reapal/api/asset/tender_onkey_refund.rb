# coding: utf-8

module Reapal
  module Api
    module Asset
      module TenderOneKeyRefund

        # 3.13 一键还款
        #
        # @param order_no [ String ] 还款订单号
        # @param tender_no [ String ] 商户系统标的的标号
        # @param debit_contracts [String] 借款方协议号
        # @param debit_details [JSON] 借款方还款
        #   *seria_no [String] 还款流水号
        #   *payee_contracts [String] 收款方协议号
        #   *amount [String] 金额
        #   *remark [String] 备注
        # @param invest_details [JSON] 投资方分账
        #   *seria_no [String] 还款分账流水号
        #   *invest_contracts [String] 投资方协议号
        #   *payee_contracts [String] 收款方协议号
        #   *amount [String] 金额
        #   *remark [String] 备注
        # @param defray_details [JSON] 担保方分账
        #   *seria_no [String] 还款流水号
        #   *payee_contracts [String] 付款方协议号
        #   *amount [String] 金额
        #   *remark [String] 备注
        # @param busway [ String ] 设备通道 00：PC端；01：手机端；02：Pad端；03：其它
        # @param remark [ String ] 备注
        #
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
        def tender_onekey_refund(order_no,
                                 tender_no,
                                 debit_contracts,
                                 debit_details,
                                 invest_details='',
                                 defray_details='',
                                 busway='01',
                                 remark='')
          service = 'reapal.trust.onekeyRefund'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: order_no,
            tenderNo: tender_no,
            debitContracts: debit_contracts,
            debitDetails: debit_details,
            investDetails: invest_details,
            defrayDetails: defray_details,
            busway: busway,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
          }

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          #非返回类错误
          return res if response.http_pending? # 比如超时等操作

          # 只有返回码是 '0000'发标才成功
          if ['0000'].include?(response.data[:resultCode])
            res[:result] = "S"
          end

          #确定的错误
          if Reapal::Api::ErrorCode.tender_onekey_refund.include?(response.data[:errorCode])
            res[:result] = "F"
            return res
          end

          # 不能确定的错误 ，pending
          res
        end

      end # module TenderOneKeyRefund
    end
  end
end
