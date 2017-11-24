# coding: utf-8

module Reapal
  module Api
    module Form
      module TenderRefund

        # 3.9 还款(Form)
        #
        # @param flow_id [String] 还款订单号
        # @param tender_no [String] 标的号
        # @param debit_contrats [String] 借款方协议号
        # @param debit_detail [JSON] 借款方还款
        #   *seria_no [String] 还款流水号
        #   *payee_contracts [String] 收款方协议号
        #   *amount [String] 金额
        #   *remark [String] 备注
        # @param invest_detail [JSON] 投资方分账
        #   *seria_no [String] 还款分账流水号
        #   *invest_contracts [String] 投资方协议号
        #   *payee_contracts [String] 收款方协议号
        #   *amount [String] 金额
        #   *remark [String] 备注
        # @param busway [String] '00'：PC端；'01'：手机端(默认)；'02'：Pad端；'03'：其它

        # @return [ Hash ] 结果集
        #   * form_method
        #     * url
        #     * method
        #   * form_data
        #     * :merchant_id
        #     * :encryptkeyÍ
        #     * :data
        #
        def tender_refund_form(flow_id, tender_no, debit_contrats, debit_detail,
                               invest_details, busway='01')

          service = 'reapal.trust.tenderRefund'
          post_path = '/reagw/tender/rest.htm'

          debit_details[:serialNo] = debit_detail[:seria_no]
          debit_details[:payeeContracts] = debit_detail[:payee_contracts]
          debit_details[:amount] = debit_detail[:amount]
          debit_details[:remark] = debit_detail[:remark]

          invest_details[:seriaNo] = invest_detail[:seria_no]
          invest_details[:investContracts] = invest_detail[:invest_contracts]
          invest_details[:payeeContracts] = invest_detail[:payee_contracts]
          invest_details[:amount] = invest_detail[:amount]
          invest_details[:mark] = invest_detail[:mark]


          params = {
            orderNo: flow_id,
            tenderNo: tender_no,
            debitContracts: debit_contrats,
            debitDetails: debit_details,
            investDetails: invest_details,
            busway: busway,
            returnUrl: '',
            notifyUrl: '',
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
          }

          request = Http.get_body(service, params, @config)

          {
             form_method: {
              :url => config[:server_url] + post_path,
              :method => :post,
            },
             form_data: {
               :merchant_id => request[:merchant_id],
               :encryptkey => request[:encryptkey],
               :data => request[:data]
            }

          }

        end

      end #TenderRefund
    end
  end
end
