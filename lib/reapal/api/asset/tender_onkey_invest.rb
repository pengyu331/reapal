# coding: utf-8

module Reapal
  module Api
    module Asset
      module TenderOneKeyInvest

        # 3.6 一键投标
        #
        # @param order_no [ String ] 投标订单号
        # @param tender_no [ String ] 投标的标号
        # @param amount [ BigDecimal ] 自费金额
        # @param coupon_amt [ BigDecimal ] 红包/抵用券 ，该参数可不传，或 > 0
        # @param invest_contracts [ String ] 投资方协议号
        # @param busway [ String ] 设备通道 00：PC端；01：手机端；02：Pad端；03：其它
        # @param remark [ String ] 备注
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #      * :orderNo [String] 发标订单号
        #      * :amount [ BigDecimal ] 投标申请总金额
        #      * :realAmount [ BigDecimal ] 实际投标金额
        #      * :resultCode [String] 结果代码
        #
        def tender_onekey_invest(order_no, tender_no, amount, coupon_amt,
                                 invest_contracts, busway='01', remark='')
          service = 'reapal.trust.onekeyInvest'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: order_no,
            tenderNo: tender_no,
            amount: amount,
            couponAmt: coupon_amt,
            investContracts: invest_contracts,
            busway: busway,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          #非返回类错误
          return res if response.http_pending? # 比如超时等操作

          # 只有返回码是 '0000'发标才成功
          if ['0000'].include?(response.data[:resultCode])
            res[:result] = "S"
          end

          #确定的错误
          if Reapal::Api::ErrorCode.tender_onekey_invest.include?(response.data[:errorCode])
            res[:result] = "F"
            return res
          end

          # 不能确定的错误 ，pending
          res
        end

      end # module TenderOneKeyInvest
    end
  end
end
