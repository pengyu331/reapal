# coding: utf-8

module Reapal
  module Api
    module Asset
      module TenderApply

        # 3.1 发标
        #
        # @param flow_id [String] 发标订单号
        # @param tender_no [String] 商户系统标的号
        # @param tender_name [String] 商户系统标的名称
        # @param money [BigDecimal] 金额
        # @param rate [BigDecimal] 利率  10.3表示10.3%
        # @param debit_term [BigDecimal] 标的期限
        # @param debit_type [String] 期数类型,年：0，月：1，日：2
        # @param repay_date [String] 还款日期，格式YYYYMMDD
        # @param expiry_date [String] 投标截止日期，格式YYYYMMDD
        # @param debit_contracts [String] 借款方协议号
        # @param guarant_contract [String] 担保方协议号
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
        def tender_apply(flow_id, tender_no, tender_name, money, rate,
                                  debit_term, debit_type, rapay_date, expiry_date,
                                  debit_contracts, guarant_contract, busway='01', remark='')
          service = 'reapal.trust.tenderApply'
          post_path = '/reagw/tender/rest.htm'

          params = {
            orderNo: flow_id,
            tenderNo: tender_no,
            tenderName: tender_name,
            amount: money,
            rate: rate,
            debitTerm: debit_term,
            debitType: debit_type,
            expiryDate: expiry_date,
            debitContracts: debit_contracts,
            guarantContract: guarant_contract,
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
          if Reapal::Api::ErrorCode.tender_apply.include?(response.data[:resultCode])
            res[:result] = "F"
            return res
          end

          # 不能确定的错误 ，pending
          res
        end

      end # module TenderApply
    end
  end
end
