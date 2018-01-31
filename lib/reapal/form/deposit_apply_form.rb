# coding: utf-8

module Reapal
  module Form
    module DepositAppyForm

      # 2.1网银充值 (Form)
      #
      # @param flow_id [String] 业务订单号
      # @param contracts [String] 用户协议号
      # @param money [Number] 充值金额
      # @param charge [Number] 手续费
      # @param return_url [String] 回调 url
      # @param notify_url [String] 通知 url
      # @param remark [String] 备注(默认为 '')
      # @param payment_type [String]（默认为 1）1：表示富民银行收银台支付（默认值，此字段为空时，默认此种方式）；2：表示B2B企业充值银行直连；3： 表示B2C个人借记卡银行直连；
      # @param pay_customer_no [String] (默认为 '')支付方式（paymentType参数）为企业银行直连时：民生、浦发、交通三家银行 B2B(企业网银)支付需要提交该字段。其他情况下提交空字符串
      #
      # @return [ Hash ] 结果集
      #   * form_method
      #     * url
      #     * method
      #   * form_data
      #     * :merchant_id
      #     * :encryptkey
      #     * :data
      #
      def deposit_apply_form(flow_id, contracts, money, charge,
                             return_url, notify_url, remark='',
                             payment_type='1', pay_customer_no='')

        service = 'reapal.trust.depositApply'
        post_path = '/reagw/service/deposit.htm'

        params = {
          orderNo: flow_id,
          contracts: contracts,
          amount: money,
          charge: charge,
          returnUrl: return_url,
          notifyUrl: notify_url,
          remark: remark,
          paymentType: payment_type,
          channel: 'bank',
          payCustomerNo: pay_customer_no,
          busway: '00',
          applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
        }

        get_form_data(service, params, post_path)
      end

    end #BusinessAuth
  end
end
