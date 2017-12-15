# coding: utf-8
# 用户 API 错误相关
module Reapal
  module Http
    module ErrorCode

      def self.contract_common
        @_contract_common ||= %w(0101 0102 0103 0104 0105 0106 0107 0108 0109 0110
                                 0111 0112 0113 0114 0115 0116 0117 0118 0119 0120
                                 0121 0122 0123 0124 0125 0126 0127 0128 0129 0130
                                 0131 0132 0150 0151 0152 0153 0154 0155 0156 0157
                                 0158 0159 0160 0161 0162 0163 0164 0165 0166 0167) | common
      end

      def self.contract_create
        @_contract_create ||= contract_common
      end

      def self.com_contract_create
        @_com_contract_common ||= ['9015', '0525'] | contract_common
      end

      def self.contract_query
        @_contract_query ||= contract_common
      end

      def self.mobile
        @_mobile ||= ['1108'] | contract_common
      end

      def self.bind_card
        @_bind_card ||= %w(9060 9064 9065 9083 9084 9085 0017 0302 0303 0328
                           0329 0330 0332 0333 0335 0339 0340 0341 0342 0343
                           0345 0346 0347 0348 0350 0351 0352 0358 0359 0360
                           0362 0363) | contract_common
      end

    end # module ErrorCode
  end
end
