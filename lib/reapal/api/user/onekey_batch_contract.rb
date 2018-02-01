# coding: utf-8

module Reapal
  module Api
    module User
      module OnekeyBatchContract

        # 5.2 历史用户迁移（四要素）
        #
        # @param flow_id [ String ] 订单号
        # @param true_name [ String ] 真实姓名
        # @param identity_id [ String ] 身份证号
        # @param phone [ String ] 手机号
        # @param is_to_sms [ String ] 是否发送初始交易密码短信，T:发送  F：不发送
        # @param bank_code [ String ] 银行代码
        # @param card_id [ String ] 银行卡账号（全卡号）
        # @param card_province [ String ] 银行所在省
        # @param card_city [ String ] 银行所在城市
        # @param card_branch [ String ] 银行分行
        # @param card_sub_branch [ String ] 银行支行
        # @param user_type [ String ] 注册类别 01：出借人 02：借款人 03：担保人 04：受托方
        # @param busway [ String ] 设备通道，默认手机端 00：PC端；01：手机端；02：Pad端；03：其它
        # @param remark [ String ] 备注
        #
        # @return [ Hash ] 结果集
        #   * :result [String] "S"/"F"/"P"
        #   * :error_msg [String] 错误提示
        #   * :error_code [String] 融宝的错误编号
        #   * :data [Hash] 成功数据，返回的数据不一定是上送数据，比如手机号。所以要以返回数据为准
        #       * :contracts [String] 用户签约协议号
        #       * :userName [String] 姓名
        #       * :userIdentity [String] 身份证
        #       * :userMobile [String] 手机号
        #
        def onekey_batch_contract(flow_id, true_name, identity_id, phone, is_to_sms,
                                  bank_code, card_id, card_province, card_city, card_branch,
                                  card_sub_branch, user_type,
                                  bus_way='01', remark='')
          service = 'reapal.trust.onekeyBatchContract'
          post_path = '/reagw/agreement/agree.htm'

          params = {
            orderNo: flow_id,
            userName: true_name,
            userIdentity: identity_id,
            userMobile: phone,
            busway: bus_way,
            remark: remark,
            isToSms: is_to_sms,
            bankCode: bank_code,
            bankAccountNo: card_id,
            accountProvince: card_province,
            accountCity: card_city,
            branch: card_branch,
            subbranch: card_sub_branch,
            userType: user_type,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.contract_create, ['0000', '0007'])

          Reapal.logger.info res

          res
        end

      end # module Agree
    end
  end
end
