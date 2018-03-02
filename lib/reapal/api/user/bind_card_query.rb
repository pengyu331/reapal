# coding: utf-8

module Reapal
  module Api
    module User
      module BindCardQuery

        # 1.10 绑卡查询（API）
        #
        # @param contracts [ String ] 用户协议号
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #     * :contracts [String] 用户协议号
        #     * :bankCards [Array] 银行卡信息数组
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
        def bind_card_query(contracts)
          service = 'reapal.trust.bindQuery'
          post_path = '/user/restApi.htm'

          params = {
            contracts: contracts,
            type: 'W', # 业务类型：默认提现  A: 充值和提现; D: 充值; W: 提现 (现只支持提现绑卡查询)
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
          }

          res = operate_post(:query, service, params, post_path, Http::ErrorCode.bind_card, ['0000'])

          if 'S' == res[:result] || ('P' == res[:result] && res[:data][:resultCode].nil?)
            res[:result] = 'S'

            res[:data][:bankCards] = parse_cards_info(res[:data][:bankCards])
          end

          Reapal.logger.info res

          res
        end

        private

        def parse_cards_info(bank_cards)
          cards_info = bank_cards.first.split("|")

          cards_info
        end

      end # module
    end
  end
end
