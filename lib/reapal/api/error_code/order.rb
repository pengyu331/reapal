# coding: utf-8
# 订单查询 API 错误相关
module Reapal
  module Api
    module ErrorCode

      def self.query_by_single_order_no
        @_query_by_single_order_no ||= ['0001'] | tender_common
      end

      def self.query_by_order_no
        @_query_by_order_no ||= ['0001'] | tender_common
      end

    end # module ErrorCode
  end
end
