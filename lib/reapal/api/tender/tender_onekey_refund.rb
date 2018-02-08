# coding: utf-8

module Reapal
  module Api
    module Tender
      module TenderOneKeyRefund

        # 3.8 一键还款
        #
        # @param flow_id [ String ] 还款订单号
        # @param tender_no [ String ] 商户系统标的的标号
        # @param periods [ Integer ] 还款期数
        # @param debit_contracts [ String ] 借款方协议号
        # @param debit_details [ Array ] 借款方还款
        #   *serialNo [String] 还款流水号
        #   *payeeContracts [String] 收款方协议号
        #   *tradeAmount [BigDecimal] 还款总金额 = 还款本金+还款利息+还款手续费+还款罚息
        #   *feeAmount [BigDecimal] 还款手续费
        #   *defAmount [BigDecimal] 还款罚息
        #   *amount [BigDecimal] 还款金额
        #   *intAmt [BigDecimal] 还款利息
        #   *remark [String] 备注
        # @param fee_details [ Array ] 手续费明细
        #   *serialNo [String] 还款分账流水号
        #   *payeeContracts [ String ] 收款方协议号
        #   *feeType [String] 手续费类型 01 平台收借款方手续费，不能大于标的备案的手续费 02 罚息
        #   *amount [BigDecimal] 金额
        #   *remark [String] 备注
        # @param defray_details [ Array ] 担保方明细
        #   *serialNo [String] 还款流水号
        #   *payerContracts [String] 担保方协议号
        #   *amount [BigDecimal] 金额
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
        def tender_onekey_refund(flow_id,
                                 tender_no,
                                 periods,
                                 debit_contracts,
                                 debit_details,
                                 fee_details=[],
                                 defray_details=[],
                                 busway='01',
                                 remark='')
          service = 'reapal.trust.onekeyRefund'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: flow_id,
            tenderNo: tender_no,
            debitContracts: debit_contracts,
            debitDetails: debit_details,
            feeDetails: fee_details,
            defrayDetails: defray_details,
            periods: periods,
            busway: busway,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.tender_onekey_refund, ['0000'])
          if 'S' == res[:result] && '0001' == res[:data][:resultCode]
            res[:result] = 'F'
          end

          Reapal.logger.info res

          res
        end

      end # module TenderOneKeyRefund
    end
  end
end
