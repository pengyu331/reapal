# coding: utf-8
# 客户端

module Reapal
  class Client

    attr_accessor :config

    def initialize(options_arg)
      options = Utils.symbolize_keys(options_arg)
      @config = {
        server_url: options[:server_url],
        partner_id: options[:partner_id],
        merchant_id: options[:merchant_id],
        md5_key: options[:md5_key],
        private_key: OpenSSL::PKey::RSA.new(options[:private_key], options[:private_key_pwd]),
        public_key: OpenSSL::X509::Certificate.new(options[:public_key]).public_key,
      }

      # 自动 include api 下的模块
      recursive_include_api('Reapal::Api')
      # 自动 include form 下的模块
      recursive_include_api('Reapal::Form')
    end

    def decode_notify_data(encryptkey, data)
      ::Reapal::Http::Decode.decode_notify_data(encryptkey, data, @config)
    end

    private
    def recursive_include_api(module_chain)
      modules = eval("#{module_chain}.constants").each{ |constant| eval("#{module_chain}::#{constant}").class.kind_of?(Module) }

      if modules.empty?
        self.class.send(:include, eval(module_chain))
      else
        modules.each{ |constant| recursive_include_api("#{module_chain}::#{constant}") }
      end
    end

  end
end
