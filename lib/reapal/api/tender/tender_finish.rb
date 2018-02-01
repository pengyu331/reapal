# coding: utf-8

module Reapal
  module Api
    module Tender
      module TenderFinish

        # 3.7 满标 API
        #
        # @param flow_id [ String ] 完成订单号
        # @param tender_no [ String ] 商户系统标的号
        # @param debit_contracts [ String ] 借款方协议号
        # @param fee_details [ Array ] 手续费分账
        #   * :seriaNo [String] 商户流水号
        #   * :payeeContracts [String] 收款方协议号
        #   * :feeType [String] 01 收借款人手续费【包括平台和担保方，共享发标时的手续费】 02 受托支付
        #   * :amount [BigDecimal] 金额
        #   * :remark [String] 备注
        # @param invest_details [ Array ] 投资方分账
        #   * :seriaNo [String] 商户流水号
        #   * :investContracts [String] 投资方协议号
        #   * :payeeContracts [String] 收款方协议号
        #   * :amount [BigDecimal] 金额
        #   * :remark [String] 备注
        # @param busway [ String ] 设备通道， '00'：PC端；'01'：手机端(默认)；'02'：Pad端；'03'：其它
        # @param remark [ String ] 备注
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #      * :orderNo [String] 完成订单号
        #      * :resultCode [String] 结果代码
        #
        def tender_finish(flow_id, tender_no, debit_contracts, fee_details,
                          invest_details, busway='01', remark='')
          service = 'reapal.trust.tenderFinish'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: flow_id,
            tenderNo: tender_no,
            debitContracts: debit_contracts,
            feeDetails: debit_details,
            investDetails: invest_details,
            busway: busway,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.tender_finish, ['0000'])
          if 'S' == res[:result] && '0001' == res[:data][:resultCode]
            res[:result] = 'F'
          end

          Reapal.logger.info res

          res
        end

      end # module TenderFinish
    end
  end
end
