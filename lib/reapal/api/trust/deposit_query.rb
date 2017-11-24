# coding: utf-8

module Reapal
  module Api
    module Trust
      module DepositQuery

        # 2.6 充值查询（API）
        #
        # @param deposit_order_no [ String ] 充值订单号
        #
        # @return [ Hash ] 结果集
        #   * :result [String] "S"/"F"/"P"
        #   * :error_msg [String] 错误提示
        #   * :data [Hash] 成功数据
        #       * :orderNo [String]  充值订单号
        #       * :amount [BigDecimal] 交易金额
        #       * :charge [BigDecimal] 手续费
        #       * :resultCode [String] 结果代码
        #
        def deposit_query(deposit_order_no)
          service = 'reapal.trust.depositQuery'
          post_path = '/reagw/service/depwit.htm'

          params = {
            orderNo: deposit_order_no,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          error_result = {
            data: nil,
            result: "F",
            error_msg: "未知错误",
          }

          # 如果数据不合法
          unless response.data_valid
            error_result[:error_msg] = "返回数据不合法"
            return error_result
          end

          # 如果网络出错，包括超时或者非200类数据
          unless response.http_response.kind_of?(Net::HTTPSuccess)
            error_result[:error_msg] = "网络出错"
            return error_result
          end

          # 充值查询只有返回码是 '0000', '0007' 才成功
          if ['0000'].include?(response.data[:resultCode])
            return {
              data: response.data,
              result: "S",
              error_msg: nil,
            }
          else
            # 普通错误
            error_result[:error_code] = response.data[:errorCode]
            error_result[:error_msg] = response.data[:errorMsg]
            return error_result
          end
        end

      end # module
    end
  end
end
