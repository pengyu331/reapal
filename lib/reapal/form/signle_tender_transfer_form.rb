# coding: utf-8

module Reapal
  module Form
    module SignleTenderTransferForm

      # 3.11 债权转让
      #
      # @param flow_id [String] 业务订单号
      # @param tender_no [String] 转让方原投资标的号
      # @param trans_capital [BigDecimal] 转让人出让的本金
      # @param money [BigDecimal] 债权转让承接人应支付金额
      # @param trans_contracts [String] 债权转让方在存管系统签约的协议号
      # @param into_contracts [String] 债权承接方在存管系统签约的协议号
      # @param transfer_type [String] 债转类型,传1表示首次债转，即转让人（transContracts）为tenderNo指代标的原始投资人,传2表示第N次债转,转让人（transContracts）并非原标的投资人
      # @param invest_order [String] 原投资订单号,若transferType为1时,即首次债转时必传
      # @param org_transfer_order [String] 原债转订单号,若transferType 为2时,即N次债转时必传
      # @param return_url [String] 回调 url
      # @param notify_url [String] 通知 url
      # @param busway [String] 00：PC端；01：手机端；02：Pad端；03：其它
      # @param fee [BigDecimal] 手续费  默认为空
      # @param fee_type [String] 手续费收取方向。 手续费收取方向 1 收取转让方，2 收取承接方 。手续费不为空时此字段必传,手续费为空时此字段不传
      # @param remark [String] 备注  默认为空
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
      def single_tender_transfer_form(flow_id,
                                      tender_no,
                                      trans_capital,
                                      money,
                                      trans_contracts,
                                      into_contracts,
                                      transfer_type,
                                      invest_order,
                                      org_transfer_order,
                                      return_url,
                                      notify_url,
                                      busway = '01',
                                      fee = '',
                                      fee_type = '',
                                      remark = '')
        service = 'reapal.trust.signleTenderTransfer'
        post_path = '/reagw/tender/rest.htm'

        params = {
          orderNo: flow_id,
          tenderNo: tender_no,
          transCapital: trans_capital,
          amount: money,
          transContracts: trans_contracts,
          intoContracts: into_contracts,
          fee: fee,
          feeType: fee_type,
          transferType: transfer_type,
          investOrder: invest_order,
          orgTransferOrder: org_transfer_order,
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
