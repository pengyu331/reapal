# coding: utf-8
# 用户 API 错误相关
module Reapal
  module Http
    module ErrorCode

      def self.contract_common
        ['0103']
      end

      def self.contract_create
        ['0101', '0102', '0103', '0104', '0105', '0106', '0107', '0108', '0109',
         '0110', '0111', '0112', '0113', '0114', '0115', '0116', '0117', '0118',
         '0119', '0120', '0121', '0122', '0123', '0124', '0125', '0126', '0127',
         '0128', '0129', '0130', '0131', '0132', '0150', '0151', '0152', '0153',
         '0154', '0155', '0156', '0157', '0158', '0159', '0160', '0161', '0162',
         '0163', '0164', '0165', '0166', '0167']
      end

      def self.contract_query
        ['0113']
      end

      def self.mobile
        @_mobile ||= ['1108']
      end

      def self.bind_card
        @_bind_card ||= %w(9060 9065 9083 9084 9085 0017 0210 0302 0303 0328
                           0329 0330 0332 0333 0335 0339 0340 0341 0342 0343
                           0344 0345 0346 0347 0348 0350 0351 0352 0358 0359
                           0360 0362 0363)
      end

      def self.sub_account
        @_sub_account ||= %w(0001 1601 1602 1603 1604 1605 1606 1607)
      end

      def self.sub_account_query
        @_sub_account_query ||= %w(1608 1609 1610 1611)
      end

    end # module ErrorCode
  end
end
