# coding: utf-8
module Reapal
  module Http

    SIGN_TYPE = '0' # 0 表示 md5
    VERSION = '1.0' # 版本号

    def self.post(service, params, config, post_path)
      post_body = get_body(service, params, config)
      uri = URI(config[:server_url] + post_path)

      Reapal.logger.info "[#{service}] 请求内容为：\n#{params}\n"
      Reapal.logger.info "[#{service}(#{uri})] 最终发送内容为：\n#{post_body}\n"

      result = {}

      begin
        response = Net::HTTP.post_form(uri, post_body)
        Reapal.logger.info "[#{service}] 返回的报文为：\n#{response.body}"

        if response.is_a?(Net::HTTPSuccess) # 返回 200 才处理
          response_raw_body = unpack_body(response.body, config)
          result = Reapal::Http::Response.new(service: service,
                                              flow_id: params[:orderNo],
                                              http_response: response,
                                              raw_body: response_raw_body,
                                              data: response_raw_body[:resData],
                                              data_valid: response_raw_body[:data_valid])
        else
          # 非 200 请求，结果为 Fail
          result = Reapal::Http::Response.new(service: service,
                                              flow_id: params[:orderNo],
                                              http_response: response,
                                              raw_body: response.body,
                                              data_valid: true)
        end
      rescue
        # 请求超时等网络原因，结果为 pending，等待下次查询
        result = Reapal::Http::Response.new(service: service,
                                            flow_id: params[:orderNo],
                                            http_response: response,
                                            data_valid: true)
      end

      Reapal.logger.info "[#{service}] 返回结果为：\n#{result}\n\n"

      result
    end

    # 表单的 body
    def self.get_body(service, params, config)
      data = {
        version: VERSION,
        service: service,
        partner: config[:partner_id],
        sign: Sign::MD5.sign(params.to_json, config[:md5_key]),
        signType: SIGN_TYPE,
        reqData: params.to_json,
      }

      random_key = Reapal::Utils.random_key
      body = {
        merchant_id: config[:merchant_id],
        encryptkey: Encrypt::RSA.encrypt(random_key, config[:public_key]),
        data: Encrypt::AES.encrypt(data.to_json, random_key),
      }
    end

    private

    def self.unpack_body(body_string, config)
      # 返回是 json 字符串格式
      body = Utils.symbolize_keys(JSON.parse(body_string))

      # 1. 拿到用来加密的16位随机字符串
      random_key = Encrypt::RSA.decrypt(body[:encryptkey],
                                        config[:private_key])

      # 2. 用16位随机字符串解密返回的数据
      data_string = Encrypt::AES.decrypt(body[:data], random_key)
      data = parse_data_string(data_string)
      data[:resData] = Utils.symbolize_keys(JSON.parse(data[:resData]))

      # 3. 验签，错误时候 sign 是没有值的
      if (data[:sign].nil? && data[:resData][:errorCode]) \
         || (data[:sign] && Sign::MD5.verify?(data[:resData].to_json, config[:md5_key], data[:sign]))
        data[:data_valid] = true
      else
        data[:data_valid] = false
      end

      data
    end

    # 正确的返回字符串例子：
    #    'version=1.0&service=reapal.trust.onekeyContract&signType=0&sign=cdab41a05d595d6a5f5a818af2b39398&resData={"contracts":"RB1711167FYG9U29","userName":"王五","userIdentity":"330602198711160034","userMobile":"18357101332","orderNo":"5a0d488fe0c016049a000001","resultCode":"0007","processTime":"2017-11-16 16:13:04"}'
    # 
    # 异常的返回字符串例子：
    #    '{"orderNo":"FFSS1","errorCode":"0107","service":"reapal.trust.onekeyContract","errorMsg":"姓名不能为空"}'
    def self.parse_data_string(data_string)
      result = {}
      arr = data_string.split('&')

      if 1 == arr.size # 此次返回的是异常信息
        result[:resData] = arr.first
      else
        arr.each{ |sub_str|
          sub_arr = sub_str.split('=')
          result[sub_arr[0].to_sym] = sub_arr[1]
        }
      end
      
      result
    end

  end
end
