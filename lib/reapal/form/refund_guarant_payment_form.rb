# coding: utf-8

module Reapal
  module Form
    module RefundGuarantPaymentForm

      # 3.16 借款人还代偿款
      #
      # @param flow_id [ String ] 还款订单号
      # @param tender_no [ String ] 代偿还款标的号
      # @param amount [ Bigdecimal ] 金额
      # @param fee_amount [ Bigdecimal ] 预期手续费
      # @param payee_contract [ String ] 标的对应的担保方协议号
      # @param return_url [String] 回调 url
      # @param notify_url [String] 通知 url
      # @param busway [String] 设备通道，默认手机端。00：PC端；01：手机端；02：Pad端；03：其它
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
      def mobile_modify_form(contract, new_phone, return_url, notify_url, busway='01')
        service = 'reapal.trust.refundGuarantPayment'
        post_path = '/reagw/tender/rest.htm'

        params = {
          orderNo: flow_id,
          tenderNo: tender_no,
          amount: amount,
          payeeContract: payee_contract,
          busway: busway,
          returnUrl: return_url,
          notifyUrl: notify_url,
          applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
        }

        get_form_data(service, params, post_path)
      end

    end
  end
end
