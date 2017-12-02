# coding: utf-8
module Reapal
  module Http
    module Decode

      # 解析异步通知的数据
      #
      # @param encryptkey_arg [String] 加密字符串
      # @param data_arg [String] 加密数据
      # @param config [hash] 配置信息
      #
      # @return [ Hash ] 结果集
      #   * :version [String] api 版本
      #   * :service [String] 富民服务
      #   * :sign [String] 签名
      #   * :signType [String] 签名类型
      #   * :data_valid [Boolean] 是否通过验签
      #
      #   * :resData: 如果返回正确结果
      #      * :orderNo [String] 发标订单号
      #      * :resultCode [String] 结果代码
      #      * 等其他各自业务参数
      #
      #   * :resError: 如果返回错误结果
      #      * :service [String]
      #      * :orderNo [String]
      #      * :errorCode [String]
      #      * :errorMsg [String]
      #
      def self.decode_notify_data(encryptkey_arg, data_arg, config)
        # 1. 拿到用来加密的16位随机字符串
        random_key = Encrypt::RSA.decrypt(encryptkey_arg,
                                          config[:private_key])

        # 2. 用16位随机字符串解密返回的数据
        data_string = Encrypt::AES.decrypt(data_arg, random_key)

        data = Utils.symbolize_keys(JSON.parse(data_string))
        if !data[:resData].nil?
          data[:resData] = Utils.symbolize_keys(JSON.parse(data[:resData]))
          sign_str = data[:resData].to_json
        elsif !data[:resError].nil?
          data[:resError] = Utils.symbolize_keys(JSON.parse(data[:resError]))
          sign_str = data[:resError].to_json
        end

        # 3. 验签
        if data[:sign].nil? # sign 有的时候有，有的时候没有(已经发现错误信息返回时候有这种现象)
          data[:data_valid] = true
        else
          if Sign::MD5.verify?(sign_str, config[:md5_key], data[:sign])
            data[:data_valid] = true
          else
            data[:data_valid] = false
          end
        end

        data
      end

    end
  end
end
