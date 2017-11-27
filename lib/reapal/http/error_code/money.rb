# coding: utf-8
# 支付/提现 API 错误相关
module Reapal
  module Http
    module ErrorCode

      def self.deposit_common
        @_deposit_common ||= %w(0001 0004)
      end

      def self.deposit
        @_deposit ||= %w(0000 0001 0003 0004 0005 0201 0202 0203 0204 0205
                         0206 0207 0208 0209 1701 1702 1703 1704 1705 1706
                         1707 1708 1709 1710 1711 1712 1713 1714 1801 1802
                         1803 1804 1805 1901)
      end

      def self.deposit_apply_api
        @_deposit_apply_api ||= %w(1701 1702 1703 1704 1705 1706
                                   1707 1708 1709 1710 1711 1712
                                   1713 1714) | deposit_common
      end

      def self.deposit_confirm_api
        @_deposit_confirm_api ||= %w(1901) | deposit_common
      end

      def self.deposit_sms_api
        @_deposit_sms_api ||= [] | deposit_common
      end

      def self.deposit_query
        @_deposit_query ||= %w(0208) | deposit_common
      end

      def self.withdraw_query
        @_withdraw_query ||= %w(0301 0302 0303 0304 0305 0306 0307 0308 0309
          0310 0311 0312 0313 0314 0315 0316 0317 0318 0319 0320 0321 0322
          0333 0324 0326 0327 0328 0329 0330 0331 0332 0333 0334 0335 0336
          0337 0338 0339 0340)
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
