
# API 公共错误相关
module Reapal
  module Http
    module ErrorCode

      def self.common
        @_common ||= %w(0002 0003 0004 0005 0006 0007 0008 0009 0010 0011
                        0012 0013 0014 0015 0016 0017 9001 9002 9003
                        9005 9006 9007 9008 9009 9011 9012 9013 9014 9015
                        9016 9017 9018 9019 9020 9021 9022 9023 9024 9025 9026
                        9027 9028 9029 9030 9031 9032 9033 9034 9035 9036 9037
                        9038 9039 9040 9041 9042 9043 9044 9045 9046 9047 9048
                        9049 9050 9051 9052 9053 9054 9055 9056 9056 9057 9058
                        9059 9060 9061 9062 9063 9064 9065 9066 9067 9068 9069)
      end

    end # module ErrorCode
  end
end
