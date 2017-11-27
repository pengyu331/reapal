module Reapal
  module Api
    module ErrorCode

      def self.common
        ['0001']
      end

      def self.contract_common
        ['0103']
      end

      def self.bind_card
        @_bind_card ||= %w(9060 9065 9083 9084 9085 0017 0210 0302 0303 0328 0329
                           0330 0332 0333 0335 0339 0340 0341 0342 0343 0344 0345
                           0346 0347 0348 0350 0351 0352 0358 0359 0360 0362 0363)
      end

      def self.deposit
        @_deposit ||= %w(0000 0001 0003 0004 0005 0201 0202 0203 0204 0205 0206
                         0207 0208 0209 1701 1702 1703 1704 1705 1706 1707 1708
                         1709 1710 1711 1712 1713 1714 1801 1802 1803 1804 1805
                         1901)
      end

      def self.sub_account
        @_sub_account ||= %w(0001)
      end

      def self.deposit_common
        @_deposit_common ||= %w(0001 0004)
      end

      def self.deposit_apply_api
        @_deposit_apply_api ||= %w(1701 1702 1703 1704 1705 1706 1707 1708 1709 1710 1711
                         1712 1713 1714) | deposit_common
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

      def tender_common
        @_tender_common = %w(0400 0401 0402 0405 0406 0407 0408 0409 0410)
      end

      def self.mobile
        @_mobile ||= ['1108']
      end

      def self.tender_cancel
        @_tender_cancel ||= %w(0700 0701 0702 0703 0704 0705 0706 0707 0708 0709
                               0710 0711 0712 0713 0714 0715 0716 0717 0718 0719
                               1501 1502 1503 1504 1505 1506 1507 1508)
      end


      def self.tender_apply
        @_tender_apply ||= %w(0500 0501 0502 0503 0504 0505 0506 0507 0508 0509 0510 0511 0512 0513 0514 0515 0516 0517 0518 0519 0520 0521 0522 0523 0524 0525 0526 0527 0528 0529 0530 0531 0532 0533 0534 0535 0536)
      end

      def self.tender_repayment_project
        @_tender_repayment_project ||= [].merge(@_tender_common)
      end

      def self.tender_repayment_complete
        @_tender_repayment_complete ||= [].merge(@_tender_common)
      end

      def self.tender_auth_query
        @_tender_auth_query ||= [].merge(@_tender_common)
      end

      def tender_auth_cancel
        @_tender_auth_cancel ||= [].merge(@_tender_common)
      end

      def tender_finish
        @_tender_finish ||= [].merge(@_tender_common)
      end

    end
  end
end
