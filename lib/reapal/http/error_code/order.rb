# coding: utf-8
# 订单查询 API 错误相关
module Reapal
  module Http
    module ErrorCode

      def self.query_by_single_flow_id
        @_query_by_single_flow_id ||= ['0001'] | tender_common
      end

      def self.query_by_flow_id
        @_query_by_flow_id ||= ['0001'] | tender_common
      end

    end # module ErrorCode
  end
end
