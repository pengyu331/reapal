# coding: utf-8

module Reapal
  module Api
    module Trust
      module UndoBindBankCard

        # 1.13 撤销绑卡 (API)
        #
        # @param order_no [ String ] 订单号
        # @param contract [ String ] 用户协议号
        # @param bank_account_no [ String ] 银行卡信息（卡号后四位）
        #
        # @return [ Hash ] 结果集
        #   * :result [String] "S"/"F"/"P"
        #   * :error_msg [String] 错误提示
        #   * :error_code [String] 融宝的错误编号
        #   * :data [Hash] 成功数据，返回的数据不一定是上述数据，所以要以返回数据为准
        #       * :orderNo [String] 订单号
        #       * :resultCode [String] 结果代码 0000：撤销绑卡成功
        #
        def undo_bind_bank_card(order_no, contracts, bank_account_no)
          service = 'reapal.trust.undoBindBankCard'
          post_path = '/reagw/bankcard/undoBindBankApi.htm'

          params = {
            orderNo: order_no,
            contracts: contracts,
            bankAccountNo: bank_account_no,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
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

          # 撤销绑卡只有返回码是 '0000' 才成功
          if ['0000'].include?(response.data[:resultCode])
            return {
              data: response.data,
              result: "S",
              error_msg: nil,
            }
          else
            error_result[:error_code] = response.data[:errorCode]
            error_result[:error_msg] = response.data[:errorMsg]
            return error_result
          end
        end

      end # module
    end
  end
end
