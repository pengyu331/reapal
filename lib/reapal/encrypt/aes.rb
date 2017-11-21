# coding: utf-8
module Reapal
  module Encrypt
    module AES

      def self.encrypt(content, key)
        cipher = OpenSSL::Cipher.new("AES-128-ECB")
        cipher.encrypt
        cipher.key = key
        encrypted = cipher.update(content) + cipher.final
        Base64.strict_encode64(encrypted)
      end

      def self.decrypt(content, key)
        encrypted = Base64.strict_decode64(content)
        cipher = OpenSSL::Cipher.new("AES-128-ECB")
        cipher.decrypt
        cipher.key = key
        cipher.update(encrypted) + cipher.final
      end

    end
  end
end
