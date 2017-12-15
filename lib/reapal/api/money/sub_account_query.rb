# coding: utf-8

module Reapal
  module Api
    module Money
      module SubAccountQuery

        # 2.12 企业分账查询（API）
        #
        # @param sub_account_flow_id [ String ] 分账订单号
        # @param serial_no [ String ] 分账流水号（传空串表示该订单批量查询）
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #       * :orderNO [String] 分账订单号
        #       * :subDetails [String]  分账明细
        #           * serialNo [String] 分账流水号
        #           * payeeContracts [String] 收款方协议号
        #           * amount [BigDecimal] 金额
        #           * remark [String] 备注
        #           * resultCode [String] 结果代码
        #       * :resultCode [String] 结果代码 0000：分账成功；0001 : 分账失败；0002：处理中
        #
        def sub_account_query(sub_account_flow_id, serial_no='')
          service = 'reapal.trust.subAccountQuery'
          post_path = '/reagw/service/depwit.htm'

          params = {
            orderNo: sub_account_flow_id,
            serialNo: serial_no,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:query, service, params, post_path, Http::ErrorCode.sub_account_query, ['0000'])

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
