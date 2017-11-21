# coding: utf-8
module Reapal
  module Encrypt
    module RSA

      def self.encrypt(content, public_key)
        content_str = public_key.public_encrypt(content)
        Base64.strict_encode64(content_str)
      end

      def self.decrypt(content, private_key)
        content_str = Base64.strict_decode64(content)
        private_key.private_decrypt(content_str)
      end

    end
  end
end
