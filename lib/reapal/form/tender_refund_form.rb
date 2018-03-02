# coding: utf-8

module Reapal
  module Form
    module TenderRefundForm

      # 还款
      #
      # @param flow_id [ String ] 还款订单号
      # @param tender_no [ String ] 商户系统标的的标号
      # @param debit_contracts [ String ] 借款方协议号
      # @param debit_details [ Array ] 借款方还款明细
      #   * :seriaNo [String] 还款流水号
      #   * :payeeContracts [String] 收款方协议号
      #   * :tradeAmount [Number] 还款总金额
      #   * :feeAmount [Number] 还款手续费
      #   * :defAmount [Number] 还款罚息
      #   * :amount [Number] 还款本金
      #   * :intAmt [Number] 还款利息
      #   * :remark [String] 备注
      # @param periods [ Integer ] 还款期数
      # @param return_url [ String ] 回调 url
      # @param notify_url [ String ] 通知 url
      # @param fee_details [ Array ] 手续费分账明细
      #   * :seriaNo [String] 还款分账流水号
      #   * :payeeContracts [String] 收款方协议号，只能是平台
      #   * :feeType [String] 手续费类型 01 平台收借款方手续费，不能大于标的备案的手续费 02 罚息，每种类型只能有一条记录
      #   * :amount [String] 金额
      #   * :remark [String] 备注
      # @param defray_details [ Array ] 担保方分账明细
      #   * :seriaNo [String] 还款流水号
      #   * :payeeContracts [String] 担保方协议号
      #   * :amount [String] 金额
      #   * :remark [String] 备注
      # @param busway [ String ] 设备通道 00：PC端；01：手机端；02：Pad端；03：其它
      # @param remark [ String ] 备注
      #
      # @return [ Hash ] 结果集
      #   * :form_method
      #     * :method
      #     * :url
      #   * :form_data
      #     * :merchant_id
      #     * :encryptkey
      #     * :data
      #
      def tender_refund_form(flow_id,
                             tender_no,
                             debit_contracts,
                             debit_details,
                             periods,
                             return_url,
                             notify_url,
                             fee_details = [],
                             defray_details = [],
                             busway = '01',
                             remark = '')
        service = 'reapal.trust.tenderRefund'
        post_path = '/tender/rest.htm'

        params = {
          orderNo: flow_id,
          tenderNo: tender_no,
          debitContracts: debit_contracts,
          debitDetails: debit_details,
          feeDetails: fee_details,
          defrayDetails: defray_details,
          periods: periods,
          returnUrl: return_url,
          notifyUrl: notify_url,
          busway: busway,
          remark: remark,
          applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
        }

        get_form_data(service, params, post_path)
      end

    end # module
  end
end
