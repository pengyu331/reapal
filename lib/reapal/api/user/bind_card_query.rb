# coding: utf-8

module Reapal
  module Api
    module User
      module BindCardQuery

        # 1.15 绑卡查询（API）
        #
        # @param contracts [ String ] 用户协议号
        # @param type [ String ] 业务类型  A: 充值和提现; D: 充值; W: 提现 (现只支持提现绑卡查询)
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #     * :contracts [String] 用户协议号
        #     * :bank_cards [Array] 银行卡信息数组 
        #       * :bank_name  银行名称
        #       * :bank_code  银行代码
        #       * :bank_card  银行卡后四位
        #       * :type  业务类型  A: 充值和提现; D: 充值; W: 提现
        #       * :is_safety  绑卡类别  0: 普通卡; 1:安全卡
        #       * :is_required_field  分支行信息  0: 省市分支行信息(系统默认信息); 1:用户自己所填信息
        #       * :account_province  开户行所在省
        #       * :account_city  开户行所在市
        #       * :branch  开户行分行
        #       * :subbranch  开户行支行
        #
        def bind_card_query(contracts, type = "W")
          service = 'reapal.trust.bindQuery'
          post_path = '/reagw/user/restApi.htm'

          params = {
            contracts: contracts,
            type: type,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
          }

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          # 查询类 api，http 没成功都返回 pending
          return res unless response.http_success?

          if Api::ErrorCode.bind_card.include?(response.data[:errorCode])
            res[:result] = 'F'
            return res
          end

          # 其余 api 错误不知道
          return res unless response.data[:errorCode].nil?

          res[:result] = 'S'
          res[:data][:bank_cards] = parse_cards_info(res[:data][:bank_cards])

          res
        end

      end # module
    end
  end
end
