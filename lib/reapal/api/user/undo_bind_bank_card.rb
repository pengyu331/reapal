# coding: utf-8

module Reapal
  module Api
    module User
      module UndoBindBankCard

        # 1.13 撤销绑卡 (API)
        #
        # @param order_no [ String ] 订单号
        # @param contract [ String ] 用户协议号
        # @param bank_account_no [ String ] 银行卡信息（卡号后四位）
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
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

          res = Reapal::Utils.api_result(params, response)

          return res if response.http_pending? # 比如超时等操作

          # 1，明确失败的
          if Api::ErrorCode.bind_card.include?(response.data[:errorCode])
            res[:result] = 'F'
            return res
          end

          # 2. 明确正确的
          if ['0000'].include?(response.data[:resultCode])
            res[:result] = 'S'
            return res
          end

          # 3. 其他错误 pending
          res
        end

      end # module
    end
  end
end
