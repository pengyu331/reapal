# coding: utf-8

module Reapal
  module Form
    module DepositApplyForm

      # 2.1 充值
      #
      # @param flow_id [String] 业务订单号
      # @param contracts [String] 用户协议号
      # @param money [Number] 充值金额
      # @param charge [Number] 手续费
      # @param return_url [String] 回调 url
      # @param notify_url [String] 通知 url
      # @param busway [ String ] 默认01 00：网银充值；01：快捷充值
      # @param remark [String] 备注(默认为 '')
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
      def deposit_apply_form(flow_id, contract, money, charge,
                             return_url, notify_url,
                             busway = '01', remark='')

        service = 'reapal.trust.depositApply'
        post_path = '/reagw/service/deposit.htm'

        params = {
          orderNo: flow_id,
          contracts: contract,
          amount: money,
          charge: charge,
          returnUrl: return_url,
          notifyUrl: notify_url,
          remark: remark,
          busway: busway,
          applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
        }

        params.merge(channel: 'bank', paymentType: '1', payCustomerNo: '') if '00' == busway

        get_form_data(service, params, post_path)
      end

    end # module
  end
end
