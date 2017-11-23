# coding: utf-8

module Reapal
  module Api
    module Form
      module SignleTenderTransfer

        # 3.16 债权转让(Form)
        #
        # @param order_no [String] 业务订单号
        # @param tender_no [String] 转让方原投资标的号
        # @param trans_capital [BigDecimal] 转让人出让的本金
        # @param amount [BigDecimal] 债权转让承接人应支付金额
        # @param trans_contracts [String] 债权转让方在存管系统签约的协议号
        # @param into_contracts [String] 债权承接方在存管系统签约的协议号
        # @param transfer_type [String] 债转类型
        # @param invest_order [String] 若transferType为1时,即首次债转时必传
        # @param org_transfer_order [String] 若transferType 为2时,即N次债转时必传
        # @param busway [String] 00：PC端；01：手机端；02：Pad端；03：其它

        # @return [ Hash ] 结果集
        #   * form_method
        #     * url
        #     * method
        #   * form_data
        #     * :data
        #
        def signle_tender_transfer_form(order_no, tender_no, trans_capital, amount, into_contracts,
                                   transfer_type, invest_order, org_transfer_order, busway='01')

          service = 'reapal.trust.signleTenderTransfer'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: order_no,
            tenderNo: tender_no,
            transCapital: trans_capital,
            amount: amount,
            transContracts: trans_contracts,
            intoContracts: into_contracts,
            fee: '',
            feeType: '',
            transferType: transfer_type,
            investOrder: invest_order,
            orgTransferOrder: org_transfer_order,
            busway: busway,
            returnUrl: '',
            notifyUrl: '',
            remark: '',
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
          }

          request = Http.get_body(service, params, @config)

          {
             form_method: {
              :url => config[:server_url] + post_path,
              :method => :post,
            },
             form_data: {
              :data => request
            }

          }

        end

      end #SignleTenderTransfer
    end
  end
end
