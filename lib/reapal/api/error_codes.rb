module Reapal
  module  Api
    module ErrorCode
      def self.mobile
        @_mobile ||= ['1108']
      end

      def self.tender_cancel
        @_tender_cancel =|| %w(0700 0701 0702 0703 0704 0705 0706 0707 0708 0709
                               0710 0711 0712 0713 0714 0715 0716 0717 0718 0719
                               1501 1502 1503 1504 1505 1506 1507 1508)
      end


      def self.tender_apply
        @_tender_apply =|| %w(0500 0501 0502 0503 0504 0505 0506 0507 0508 0509 0510 0511 0512 0513 0514 0515 0516 0517 0518 0519 0520 0521 0522 0523 0524 0525 0526 0527 0528 0529 0530 0531 0532 0533 0534 0535 0536)
      end


    end
  end
end
