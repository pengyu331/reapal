# coding: utf-8

module Reapal
  module Api
    module Money
      module SubAccount

        # 2.11 企业分账（API）
        #
        # @param order_no [ String ] 完成订单号
        # @param sub_type [ String ] 分账类型 1：代还款。2：分账。3：其它
        # @param sub_details [ Hash ] 分账明细
        #          * serial_no [String] 分账流水号
        #          * payee_contracts [String] 收款方协议号
        #          * amount [BigDecimal] 金额
        #          * mark [String] 备注
        # @param remark [ String ] 业务备注信息
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #      * :order_no [String] 完成订单号
        #      * :result_code [String] 结果代码 0000：分账成功 0001:失败
        #
        def sub_account(order_no, sub_type, sub_details, remark ='')
          service = 'reapal.trust.subAccount'
          post_path = '/reagw/service/depwit.htm'

          subDetails = [{
            serialNo: sub_details[:serial_no],
            payeeContracts: sub_details[:payee_contracts],
            amount: sub_details[:amount],
            remark: sub_details[:mark]
          }]

          params = {
            orderNo: order_no,
            subType: sub_type,
            subDetails: subDetails.to_json,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          return res if response.http_pending? # 比如超时等操作

          # 1，明确失败的
          if Api::ErrorCode.sub_account.include?(response.data[:errorCode])
            res[:result] = 'F'
            return res
          end

          # 2. 明确正确的
          if ['0000'].include?(response.data[:resultCode])
            res[:result] = 'S'
            return res
          end

          # 3. pending
          res
        end

      end # module
    end
  end
end
