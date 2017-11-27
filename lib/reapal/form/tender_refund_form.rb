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
        # @param debit_detail [hash] 借款方还款
        #   *seria_no [String] 还款流水号
        #   *payee_contracts [String] 收款方协议号
        #   *amount [BigDecimal] 金额
        #   *remark [String] 备注
        # @param invest_detail [hash] 投资方分账
        #   *seria_no [String] 还款分账流水号
        #   *invest_contracts [String] 投资方协议号
        #   *payee_contracts [String] 收款方协议号
        #   *amount [BigDecimal] 金额
        #   *remark [String] 备注
        # @param busway [String] '00'：PC端；'01'：手机端(默认)；'02'：Pad端；'03'：其它
        # @param return_url [String] 回调 url
        # @param notify_url [String] 通知 url
        # @param remark [String] 备注


        # @return [ Hash ] 结果集
        #   * form_method
        #     * url
        #     * method
        #   * form_data
        #     * :merchant_id
        #     * :encryptkeyÍ
        #     * :data
        #
        def tender_refund_form(flow_id, tender_no, debit_contrats, debit_details,
                               invest_details, return_url, notify_url, remark='', busway='01' )

          service = 'reapal.trust.tenderRefund'
          post_path = '/reagw/tender/rest.htm'

          debit_detail = {}
          debit_detail[:serialNo] = debit_details[:seria_no]
          debit_detail[:payeeContracts] = debit_details[:payee_contracts]
          debit_detail[:amount] = debit_details[:amount]
          debit_detail[:remark] = debit_details[:remark]

          invest_detail = {}
          invest_detail[:seriaNo] = invest_details[:seria_no]
          invest_detail[:investContracts] = invest_details[:invest_contracts]
          invest_detail[:payeeContracts] = invest_details[:payee_contracts]
          invest_detail[:amount] = invest_details[:amount]
          invest_detail[:remark] = invest_details[:remark]


          params = {
            orderNo: flow_id,
            tenderNo: tender_no,
            debitContracts: debit_contrats,
            debitDetails: debit_detail.to_json,
            investDetails: invest_detail.to_json,
            busway: busway,
            returnUrl: return_url,
            notifyUrl: notify_url,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
          }

          request = Http.get_body(service, params, @config)

          {
             form_method: {
              :url => config[:server_url] + post_path,
              :method => :post,
            },
             form_data: request

          }

        end

      end #TenderRefund
    end
  end
end
