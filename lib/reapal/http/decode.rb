# coding: utf-8
module Reapal
  module Http
    module Decode

      def self.decode_notify_data(encryptkey_arg, data_arg, config)
        # 1. 拿到用来加密的16位随机字符串
        random_key = Encrypt::RSA.decrypt(encryptkey_arg,
                                          config[:private_key])

        # 2. 用16位随机字符串解密返回的数据
        data_string = Encrypt::AES.decrypt(data_arg, random_key)

        data = Utils.symbolize_keys(JSON.parse(data_string))
        data[:resData] = Utils.symbolize_keys(JSON.parse(data[:resData]))

        # 3. 验签，错误时候 sign 是没有值的
        if data[:resData][:errorCode] || (data[:sign] && Sign::MD5.verify?(data[:resData].to_json, config[:md5_key], data[:sign]))
          data[:data_valid] = true
        else
          data[:data_valid] = false
        end

        data
      end

    end
  end
end
