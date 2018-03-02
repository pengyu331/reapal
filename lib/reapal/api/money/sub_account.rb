# coding: utf-8

module Reapal
  module Api
    module Money
      module SubAccount

        # 2.8 企业分账（API）
        #
        # @param flow_id [ String ] 完成订单号
        # @param sub_type [ String ] 分账类型 1：代还款。2：分账。3：其它
        # @param sub_details [ Array ] 分账明细
        #          * :serialNo [String] 分账流水号
        #          * :payeeContracts [String] 收款方协议号
        #          * :amount [BigDecimal] 金额
        #          * :remark [String] 备注
        # @param remark [ String ] 业务备注信息
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #      * :flow_id [String] 完成订单号
        #      * :result_code [String] 结果代码 0000：分账成功 0001:失败
        #
        def sub_account(flow_id, sub_type, sub_details, remark ='')
          service = 'reapal.trust.subAccount'
          post_path = '/service/depwit.htm'

          params = {
            orderNo: flow_id,
            subType: sub_type,
            subDetails: sub_details,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.sub_account, ['0000'])

          if 'P' == res[:result] && '0001' == res[:data][:resultCode]
            res[:result] = 'F'
          end

          Reapal.logger.info res

          res
        end

      end # module
    end
  end
end
