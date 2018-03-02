# coding: utf-8

module Reapal
  module Api
    module Tender
      module TenderOnekeyInvestHistory

        # 3.15 投资关系迁移 (要求标的为已满标放款状态)
        #
        # @param tender_no [ String ] 商户系统标的号
        # @param invest_details [ Array ] 投资方列表
        #   * :orderNo [String] 投标订单号
        #   * :investContracts [String] 投资方协议号
        #   * :amount [BigDecimal] 金额
        #   * :applyTime [Time] 投标时间 YYYY-MM-DD HH:mm:ss
        #   * :remark [String] 备注
        # @param remark [ String ] 业务备注，默认为空
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #      * :tenderNo [String] 完成订单号
        #      * :resultCode [String] 结果代码 0000：表示迁移成功
        #
        def tender_onekey_invest_history(tender_no, invest_details, remark='')
          service = 'reapal.trust.onekeyInvestHistory'
          post_path = '/tender/rest.htm'

          params = {
            tenderNo: tender_no,
            investDetails: invest_details,
            remark: remark,
            applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          res = operate_post(:operate, service, params, post_path, Http::ErrorCode.tender_onekey_invest, ['0000'])

          Reapal.logger.info res

          res
        end

      end # module
    end
  end
end
