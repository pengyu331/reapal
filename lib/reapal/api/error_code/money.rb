# coding: utf-8
# 支付/提现 API 错误相关
module Reapal
  module Api
    module ErrorCode

      def self.deposit_common
        @_deposit_common ||= %w(0001 0004)
      end

      def self.deposit_apply_api
        @_deposit_apply_api ||= %w(1701 1702 1703 1704 1705 1706
                                   1707 1708 1709 1710 1711 1712
                                   1713 1714) | deposit_common
      end

      def self.deposit_confirm_api
        @_deposit_confirm_api ||= %w(1901) | deposit_common
      end

    end # module ErrorCode
  end
end
