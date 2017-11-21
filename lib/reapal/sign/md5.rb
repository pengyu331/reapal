# coding: utf-8
module Reapal
  module Sign
    module MD5

      def self.sign(content, key)
        md5 = Digest::MD5.new
        md5 << (content + key)
        md5.hexdigest
      end

      def self.verify?(content, key, sign_str)
        sign(content, key) == sign_str
      end

    end
  end
end
