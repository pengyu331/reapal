# coding: utf-8
module Reapal
  module Http

    class Response
      attr_accessor :service, :flow_id
      attr_accessor :http_response, :raw_body
      attr_accessor :data, :data_valid

      def initialize(params)
        self.data_valid = true
        
        params.each do |key, value|
          instance_variable_set("@#{key}", value)
        end

        self.data = {} if self.data.nil? # 默认一定要有

        unless self.data_valid
          self.data[:errorCode] = 'sign_valid_fail'
          self.data[:errorMsg] = '数据签名错误'
        end
      end

      def [] key
        instance_variable_get("#{key}")
      end

      def to_s
        arr = ["{"]
        self.instance_variables.map{ |value|
          arr << "\t#{value.to_s} => #{self[value.to_sym]}"
        }
        arr << ["}"]
        arr.join("\n")
      end

      def http_success?
        http_response && http_response.is_a?(Net::HTTPSuccess)        
      end

      def http_fail?
        # 而 400 错误一般都是地址不存在或者没有权限，都当成错误处理
        http_response && http_response.code.to_s == '404'
      end

      def http_pending?
        # nil 的时候是超时，非 404 的其他错误都是 pending
        http_response.nil? || (!http_success? && !http_fail?)
      end

    end

  end
end
