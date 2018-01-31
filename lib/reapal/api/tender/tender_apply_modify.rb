# coding: utf-8

module Reapal
  module Api
    module Tender
      module TenderApplyModify

        # 3.3 标的信息修改 
        #
        # @param flow_id [String] 订单号
        # @param tender_no [String] 商户系统标的号
        # @param tender_name [String] 商户系统标的名称
        # @param money [BigDecimal] 金额
        # @param rate [BigDecimal] 利率  10.3表示10.3%
        # @param fee_amount [BigDecimal] 手续费
        # @param refund_term [String] 还款期数
        # @param debit_term [Integer] 标的期限
        # @param debit_type [String] 期数类型,年：0，月：1，日：2
        # @param repay_date [Time] 还款日期
        # @param expiry_date [Time] 投标截止日期
        # @param tender_type [String] 标的类别，是否允许自动投标。00：不允许自动投标 01：允许自动投标
        # @param debit_contracts [String] 借款方协议号
        # @param guarant_contract [String] 担保方协议号
        # @param commissioned_contract [String] 受托方协议号
        # @param tender_status [String] 标的状态 如果变更标的信息，则该字段为空，其他信息字段不为空，且标的状态为 01待确认。02：募集中 03：已放款 04：已结清 05：已逾期
        # @param busway [String] 设备通道， '00'：PC端；'01'：手机端(默认)；'02'：Pad端；'03'：其它
        # @param remark [String] 备注
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #      * :orderNo [String] 发标订单号
        #      * :resultCode [String] 结果代码
        #
        def tender_apply_modify(flow_id, tender_no, tender_name, money, rate, fee_amount, refund_term,
                                debit_term, debit_type, repay_date, expiry_date, tender_type, debit_contracts,
                                guarant_contract=nil, commissioned_contract=nil, tender_status=nil, busway='01', remark='')
          service = 'reapal.trust.tenderApplyModify'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: flow_id,
            tenderNo: tender_no,
            tenderName: tender_name,
            amount: money,
            rate: rate,
            feeAmount: fee_amount,
            refundTerm: refund_term,
            debitTerm: debit_term,
            debitType: debit_type,
            repayDate: repay_date.strftime("%Y%m%d"),
            expiryDate: expiry_date.strftime("%Y%m%d"),
            tenderType: tender_type,
            debitContracts: debit_contracts,
            guarantContract: guarant_contract,
            commissionedContract: commissioned_contract,
            tenderStatus: tender_status,
            busway: busway,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.tender_apply_modify, ['0000'])

          Reapal.logger.info res

          res
        end

      end # module TenderApply
    end
  end
end
