# coding: utf-8

module Reapal
  module Api
    module Money
      module DepositApplyApi

        # 2.2 快捷充值签约（API）
        #
        # @param flow_id [ String ] 订单号
        # @param contracts [ String ] 用户协议号
        # @param bank_card [ String ] 银行卡卡号
        # @param true_name [ String ] 持卡人姓名
        # @param identity_id [ String ] 身份证号
        # @param phone [ String ] 用户手机（注意是银行卡预留手机号）
        # @param amount [ BigDecimal ] 交易金额
        # @param charge [ BigDecimal ] 手续费
        # @param terminal_info [ String ] 终端信息（手机IMEI地址、MAC地址、UUID）
        # @param member_ip [ String ] 用户IP
        # @param notify_url [ String ] 通知URL
        # @param cert_type [ String ] 证件类型 （暂时只支持身份证：01）
        # @param currency [ String ] 交易币种（默认人民币（仅支持人民币cny））
        # @param bus_way [ String ] 00：PC端；01：手机端；02：Pad端；03：其它
        # @param remark [ String ] 备注
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #     * :orderNO [String] 充值订单号
        #     * :bindId [String] 绑卡ID
        #     * :certificate [String] 招商银行标识（有此标识表示充值卡为招商银行，返回值为0，
        #                                         则表示需要调用招商卡密接口，若返回值为1，
        #                                         直接调用充值确认接口。若此字段不存在则表示非招行卡，可直接调用充值确认接口完成扣款）
        #     * :resultCode [String] 结果代码
        #     * :resultMsg [String] 结果描述
        #
        def deposit_apply_api(flow_id, contracts, bank_card, true_name, identity_id,
                              phone, amount, charge, terminal_info, member_ip,
                              notify_url, cert_type = '01', currency = 'cny', bus_way = '01', remark = '')

          service = 'reapal.trust.depositApplyAPI'
          post_path = '/reagw/service/depwit.htm'

          params = {
            orderNo: flow_id,
            contracts: contracts,
            bankCard: bank_card,
            userName: true_name,
            certType: cert_type,
            userIdentity: identity_id,
            userMobile: phone,
            currency: currency,
            amount: amount,
            charge: charge,
            busway: bus_way,
            terminalInfo: terminal_info,
            memberIp: member_ip,
            notifyUrl: notify_url,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.deposit_apply_api, ['0000'], '2.0')

          Reapal.logger.info res

          res
        end

      end # module
    end
  end
end
