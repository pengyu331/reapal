# coding: utf-8

module Reapal
  module Form
    module BusinessAuthForm

      # 3.12 标的授权 (Form)
      #
      # @param flow_id [String] 业务订单号
      # @param contracts [String] 用户协议号
      # @param services [String] 授权服务 02 自动投标 03 自动还款 05 自动担保还款
      # @param auth_limit [String] 授权期限日期 YYYYMMDD
      # @param amount [Bigdecimal] 金额
      # @param total [Bigdecimal] 累计金额
      # @param return_url [String] 回调 url
      # @param notify_url [String] 通知 url
      # @param tender_no [String] 标的号,授权为一键还款时必填
      # @param busway [String] 00：PC端；01：手机端；02：Pad端；03：其它
      # @param remark [ String ] 备注
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
      def business_auth_form(flow_id, contract, services, auth_limit, amount, total_amount,
                             return_url, notify_url, busway='01', remark='')

        service = 'reapal.trust.businessAuth'
        post_path = '/reagw/user/rest.htm'

        params = {
          orderNo: flow_id,
          contracts: contract,
          services: services,
          busway: busway,
          authLimit: auth_limit,
          amount: amount,
          totalAmount: total_amount,
          returnUrl: return_url,
          notifyUrl: notify_url,
          remark: remark,
          applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
        }

        get_form_data(service, params, post_path)
      end

    end #BusinessAuth
  end
end
