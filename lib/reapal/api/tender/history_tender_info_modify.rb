# coding: utf-8

module Reapal
  module Api
    module Tender
      module HistoryTenderInfoModify

        # 3.19 历史标的信息修改
        #
        # @param flow_id [ String ] 订单号
        # @param tender_no [ String ] 商户系统标的号
        # @param fee_amount [ BigDecimal ] 手续费
        # @param refund_term [ String ] 还款期数
        # @param tender_type [String] 标的类别，是否允许自动投标。00：不允许自动投标 01：允许自动投标
        # @param debit_contracts [String] 借款方协议号
        # @param guarant_contract [String] 担保方协议号
        # @param commissioned_contract [String] 受托方协议号
        # @param tender_status [String] 标的状态 02：募集中 03：已放款 04：已结清
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
        #      * :orderNo [String] 订单号
        #      * :resultCode [String] 结果代码 0000：成功
        #
        def history_tender_info_modify(flow_id, tender_no, fee_amount, refund_term,
                                       tender_type, debit_contracts, guarant_contract=nil,
                                       commissioned_contract=nil, tender_status=nil, busway='01', remark='')
          service = 'reapal.trust.historyTenderInfoModify'
          post_path = '/tender/rest.htm'

          params = {
            orderNo: flow_id,
            tenderNo: tender_no,
            feeAmount: fee_amount,
            refundTerm: refund_term,
            tenderType: tender_type,
            debitContracts: debit_contracts,
            guarantContract: guarant_contract,
            commissionedContract: commissioned_contract,
            tenderStatus: tender_status,
            busway: busway,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.history_tender_info_modify, ['0000'])

          Reapal.logger.info res

          res
        end

      end # module TenderApply
    end
  end
end
