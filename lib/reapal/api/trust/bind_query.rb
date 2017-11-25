# coding: utf-8

module Reapal
  module Api
    module Trust
      module BindingCardQuery

        # 1.15 绑卡查询（API）
        #
        # @param contracts [ String ] 用户协议号
        # @param type [ String ] 业务类型  A: 充值和提现; D: 充值; W: 提现 (现只支持提现绑卡查询)
        #
        # @return [ Hash ] 结果集
        #   * :success [Bool] 是否为有效查询
        #   * :contracts [String] 用户协议号
        #   * :bank_cards [String] 银行卡信息 ｛bankName|bankCode|bankCard|type|isSafety|IsRequiredField|accountProvince|accountCity|branch|subbranch｝
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
        def bind_query(contracts, type = "W")
          service = 'reapal.trust.bindQuery'
          post_path = '/reagw/user/restApi.htm'

          params = {
            contracts: contracts,
            type: type,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
          }

          response = Http.post(service, params, @config, post_path)

          # 如果数据不合法
          unless response.data_valid
            return { success: false }
          end

          # 如果网络出错，包括超时或者非200类数据
          unless response.http_response.kind_of?(Net::HTTPSuccess)
            return { success: false }
          end

          # 如果 api 出异常
          if response.data[:errorCode]
            return { success: false }
          end

          {
            success: true,
            bank_cards: response.data[:bankCards]
          }
        end

      end # module
    end
  end
end
