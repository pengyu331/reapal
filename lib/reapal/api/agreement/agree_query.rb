# coding: utf-8

module Reapal
  module Api
    module Agreement
      module AgreeQuery

        # 个人一键签约（API）
        #
        # @param flow_id [ String ] 订单号
        # @param true_name [ String ] 真实姓名
        # @param identity_id [ String ] 身份证号
        # @param phone [ String ] 手机号
        # @param bus_way [ String ] 00：PC端；01：手机端；02：Pad端；03：其它
        #
        # @return [ Hash ] 结果集
        #   * :result [String] "S"/"F"/"P"
        #   * :error_msg [String] 错误提示
        #   * :data [Hash] 成功数据，解析和【个人签约API】/【企业签约API】一致
        #
        def agree_query(ori_flow_id)
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
