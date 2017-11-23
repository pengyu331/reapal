# coding: utf-8

module Reapal
  module Api
    module Form
      module BusinessAuth

        # 3.20 标的授权 (Form)
        #
        # @param order_no [String] 业务订单号
        # @param contracts [String] 用户协议号
        # @param services [String] 授权服务 02一键投标 ，03 为一键还款 04 一键债转
        # @param busway [String] 00：PC端；01：手机端；02：Pad端；03：其它
        # @param auth_limit [String] 授权期限日期 YYYYMMDD
        # @param tender_no [String] 标的号,授权为一键还款时必填
        #

        # @return [ Hash ] 结果集
        #   * form_method
        #     * url
        #     * method
        #   * form_data
        #     * :data
        #
        def business_auth_form(order_no, contracts, services, busway='01', auth_limit,
                               tender_no)

          service = 'reapal.trust.businessAuth'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: order_no,
            contracts: contracts,
            services: services,
            busway: busway,
            authLimit: auth_limit,
            tenderNo: tender_no,
            returnUrl: ''
            notifyUrl: ''
            remark: ''
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

      end #BusinessAuth
    end
  end
end
