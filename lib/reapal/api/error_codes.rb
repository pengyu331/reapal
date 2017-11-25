module Reapal
  module  Api
    module ErrorCode

      def self.tender_common
        @_tender_common = %w(0400 0401 0402 0405 0406 0407 0408 0409 0410 0411 0412
                             0413 0414 0415 0416 0417 0418 0419 0420 0421 0422 0423
                             0424 0425 0426 0427 0428 0429 0430 0431 0432 0433 0434
                             0435 0436 0437 0438 0439 0440 0441 0442 0443 0444 0445
                             0446 0447 0448 0449 0450)
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
        @_tender_repayment_project ||= [].push(@_tender_common)
      end

      def self.tender_repayment_complete
        @_tender_repayment_complete ||= [].merge(@_tender_common)
      end

      def self.tender_auth_query
        @_tender_auth_query ||= [].merge(@_tender_common)
      end

      def self.tender_auth_cancel
        @_tender_auth_cancel ||= [].merge(@_tender_common)
      end

      def self.tender_finish
        @_tender_finish ||= %w(0800 0801 0802 0803 0804 0805 0806 0807).push(@_tender_common)
      end

      def self.query_by_single_order_no
        @_query_by_single_order_no ||= ['0001'].merge(@_tender_common)
      end

      def self.query_by_order_no
        @_query_by_order_no ||= ['0001'].merge(@_tender_common)
      end

    end
  end
end
