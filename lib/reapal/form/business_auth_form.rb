# coding: utf-8

module Reapal
  module Form
    module BusinessAuthForm

      # 3.20 标的授权 (Form)
      #
      # @param flow_id [String] 业务订单号
      # @param contracts [String] 用户协议号
      # @param services [String] 授权服务 02一键投标 ，03 为一键还款 04 一键债转
      # @param auth_limit [String] 授权期限日期 YYYYMMDD
      # @param return_url [String] 回调 url
      # @param notify_url [String] 通知 url
      # @param tender_no [String] 标的号,授权为一键还款时必填
      # @param busway [String] 00：PC端；01：手机端；02：Pad端；03：其它
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
      def business_auth_form(flow_id, contracts, services, auth_limit,
                             return_url, notify_url, tender_no=nil, busway='01')

        service = 'reapal.trust.businessAuth'
        post_path = '/reagw/user/rest.htm'

        params = {
          orderNo: flow_id,
          contracts: contracts,
          services: services,
          busway: busway,
          authLimit: auth_limit,
          tenderNo: tender_no,
          returnUrl: return_url,
          notifyUrl: notify_url,
          remark: '',
          applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
        }

        get_form_data(service, params, post_path)
      end

    end #BusinessAuth
  end
end
