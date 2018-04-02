# coding: utf-8
# 投标 API 错误相关
module Reapal
  module Http
    module ErrorCode

      def self.tender_common
        @_tender_common ||= %w(0400 0401 0402 0405 0406 0407 0408 0409 0410
                               0411 0412 0413 0414 0415 0416 0417 0418 0419
                               0420 0421 0422 0423 0424 0425 0426 0427 0428
                               0429 0430 0431 0432 0433 0434 0435 0436 0437
                               0438 0439 0440 0441 0442 0443 0444 0445 0446
                               0447 0448 0449 0450) | common
      end

      def self.tender_cancel
        @_tender_cancel ||= %w(0700 0701 0702 0703 0704 0705 0706 0707 0708
                               0709 0710 0711 0712 0713 0714 0715 0716 0717
                               0718 0719 1501 1502 1503 1504 1505 1506 1507
                               1508) | tender_common
      end


      def self.tender_apply
        @_tender_apply ||= %w(0500 0501 0502 0503 0504 0505 0506 0507 0508
                              0509 0510 0511 0512 0513 0514 0515 0516 0517
                              0518 0519 0520 0521 0522 0523 0524 0525 0526
                              0527 0528 0529 0530 0531 0532 0533 0534 0535
                              0536) | tender_common
      end

      def self.tender_repayment_project
        @_tender_repayment_project ||= [] | tender_common
      end

      def self.tender_repayment_complete
        @_tender_repayment_complete ||= [] | tender_common
      end

      def self.tender_auth_query
        @_tender_auth_query ||= %w(1100 1101 1102 1103 1104 1105 1106 1107 1108 1109) | tender_common
      end

      def self.tender_auth_cancel
        @_tender_auth_cancel ||= %w(1301 1302 1303 1304 1305 1306 1307 1308 1309
                                    1310 1311 1312 1313 1314 1315 1316 1317 1318
                                    1319 1320 1321 1322 1323 1324 1325) | tender_common
      end

      def self.tender_finish
        @_tender_finish ||= %w(0801 0803 0804 0805 0806 0807) | tender_common
      end

      def self.tender_onekey_invest
        @_tender_onekey_invest ||= %w(0519 0522 0536 0600 0601 0602 0603 0606 0607
                                      0608 0609 1343 0640) | tender_common
      end

      def self.tender_onekey_refund
        @_tender_onekey_refund ||= %w(0901 0902 0903 0904 0905 0906 0907 0908 0909 0910
                                      0911 0912 0913 0914 0915 0916 0917 0918 0919 0920 0921
                                      0922 0923 0001 0942) | tender_common
      end

      def self.tender_onekey_single_transfer
        @_tender_onekey_single_transfer ||= %w(1000 1001 1002 1003 1004 1005 1006
                                               1009 1010 1011 1012 1013 0001) | tender_common
      end

      def self.tender_apply_modify
        @_tender_apply_modify ||= [] | tender_common
      end

      def self.refund_guarant_payment_query
        @_refund_guarant_payment_query ||= [] | tender_common
      end

      def self.tender_close
        @_tender_close ||= [] | tender_common
      end

      def self.history_tender_info_modify
        @_history_tender_info_modify ||= [] | tender_common
      end

    end # module ErrorCode
  end
end
