# coding: utf-8

module Reapal
  module Form
    module MemberPaymentForm

      # 2.6 会员缴费
      #
      # @param flow_id [ String ] 订单号
      # @param payment_subject [ String ] 缴费名目
      # @param amount [ String ] 金额
      # @param payer_contract [ String ] 付款方协议号
      # @param return_url [ String ] 回调 url
      # @param notify_url [ String ] 通知 url
      # @param busway [ String ] 设备通道，默认手机端。00：PC端；01：手机端；02：Pad端；03：其它
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
      def member_payment_form(flow_id, payment_subject,
                              amount, payer_contract,
                              return_url, notify_url,
                              busway='01', remark='')
        service = 'reapal.trust.memberPayment'
        post_path = '/tender/rest.htm'

        params = {
          orderNo: flow_id,
          paymentSubject: payment_subject,
          amount: amount,
          payerContract: payer_contract,
          busway: busway,
          returnUrl: return_url,
          notifyUrl: notify_url,
          remark: remark,
          applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
        }

        get_form_data(service, params, post_path)
      end

    end
  end
end
