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


    end
  end
end
