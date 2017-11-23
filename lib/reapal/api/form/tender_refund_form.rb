# coding: utf-8

module Reapal
  module Api
    module Form
      module TenderRefund

        # 3.9 还款(Form)
        #
        # @param order_no [String] 还款订单号
        # @param tender_no [String] 标的号
        # @param debit_contrats [String] 借款方协议号
        # @param debit_details [JSON] 借款方还款
        # @param invest_details [JSON] 投资方分账
        # @param busway [String] '00'：PC端；'01'：手机端(默认)；'02'：Pad端；'03'：其它

        # @return [ Hash ] 结果集
        #   * form_method
        #     * url
        #     * method
        #   * form_data
        #     * :data
        #
        def tender_refund_form(order_no, tender_no, debit_contrats, debit_details,
                          invest_details, busway='01')

          service = 'reapal.trust.tenderRefund'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: order_no,
            tenderNo: tender_no,
            debitContracts: debit_contrats,
            debitDetails: debit_details,
            investDetails: invest_details,
            busway: busway,
            returnUrl: '',
            notifyUrl: '',
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
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

      end #TenderRefund
    end
  end
end
