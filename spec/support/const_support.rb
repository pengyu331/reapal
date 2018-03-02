# coding: utf-8

# 相关常量

require 'yaml'

module ConstSupport

  def client
    config = YAML.load_file(File.join(__dir__, 'config/config.yml'))

    @client ||= Reapal::Client.new(
      server_url: config[:server_url.to_s],
      partner_id: config[:partner_id.to_s],
      merchant_id: config[:merchant_id.to_s],
      md5_key: config[:md5_key.to_s],
      public_key: config[:public_key.to_s],
      private_key: config[:private_key.to_s],
      private_key_pwd: config[:private_key_pwd.to_s],
    )
  end

end
