# coding: utf-8

module Reapal
  module Api
    module Form
      module TenderInvestForm

        # 3.2 投标（Form）（PC端）
        #
        # @param order_no [ String ] 投标订单号
        # @param tender_no [ String ] 投标的标号
        # @param amount [ BigDecimal ] 金额
        # @param coupon_amt [ BigDecimal ] 红包/抵用券
        # @param return_url [ String ] 回调 URL
        # @param notify_url [ String ] 通知 URL
        # @param remark [ String ] 备注
        # @param busway [ String ] 设备通道 00：PC端；01：手机端；02：Pad端；03：其它
        #
        # @return [ Hash ] 结果集
        #   * form_method [ Hash ]
        #     * url [ String ]
        #     * method [ String ]
        #   * form_data [ Hash ]
        #     * :merchant_id
        #     * :encryptkey
        #     * :data
        #
        def find_trade_password(order_no, tender_no, amount, coupon_amt, return_url, notify_url, remark, busway='01')
          service = 'reapal.trust.tenderInvest'
          post_path = '/reagw/tender/rest.htm'

          params = {
            order_no: order_no,
            tender_no: tender_no,
            amount: amount,
            coupon_amt: coupon_amt,
            busway: busway,
            return_url: return_url,
            notify_url: notify_url,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
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
            },
          }
        end

      end
    end
  end
end
