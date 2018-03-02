# coding: utf-8

# 相关常量

require 'yaml'

module ConstSupport

  def client
    config = YAML.load_file(File.join(__dir__, 'config/config.develop.yml'))

    config = Reapal::Utils.symbolize_keys(config)

    @client ||= Reapal::Client.new(
      config
    )
  end

end
