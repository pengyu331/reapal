# coding: utf-8

module Reapal
  module Api
    module Trust
      module ContractQuery

        # 1.5 签约查询，支持个人和企业（API）
        #
        # @param ori_flow_id [ String ] 原订单号
        #
        # @return [ Hash ] 结果集
        #   * :result [String] "S"/"F"/"P"
        #   * :error_msg [String] 错误提示
        #   * :data [Hash] 成功数据，解析和【个人签约API】/【企业签约API】一致
        #
        def contract_query(ori_flow_id)
          # TODO(tony): 目前我们只用个人签约，个人签约都是同步返回，所以先不做实现
          raise "Not Implement"

          # service = 'reapal.trust.contractQuery'
          # post_path = '/reagw/agreement/agreeApi.htm'

          # params = {
          #   orderNo: ori_flow_id,
          #   applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          # }

          # response = Http.post(service, params, @config, post_path)
        end

      end
    end
  end
end
