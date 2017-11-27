# coding: utf-8
# 用户 API 错误相关
module Reapal
  module Api
    module ErrorCode

      def self.contract_common
        ['0103']
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

      def self.deposit
        @_deposit ||= %w(0000 0001 0003 0004 0005 0201 0202 0203 0204 0205
                         0206 0207 0208 0209 1701 1702 1703 1704 1705 1706
                         1707 1708 1709 1710 1711 1712 1713 1714 1801 1802
                         1803 1804 1805 1901)
      end

      def self.sub_account
        @_sub_account ||= %w(0001)
      end

    end # module ErrorCode
  end
end
