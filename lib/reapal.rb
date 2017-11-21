# coding: utf-8
require "uri"
require "net/http"
require "json"
require "openssl"
require "base64"
require 'macaddr'
require 'byebug'
require 'logger'

require "reapal/version"
require "reapal/utils"
require "reapal/sign/md5"
require "reapal/encrypt/rsa"
require "reapal/encrypt/aes"
require "reapal/http/communicate"
require "reapal/http/response"

# 自动加载所有 api
Dir["#{File.dirname(__FILE__)}/reapal/api/**/*.rb"].each { |file|
  require file
}

require "reapal/client"

# 融宝存管
# 主入口
module Reapal

  class << self
    def logger
      @logger ||= default_logger
    end

    def default_logger
      _logger = Logger.new(STDOUT)
      _logger.level = Logger::INFO
      _logger
    end

    def logger=(log)
      @logger = (log ? log : Logger.new('/dev/null'))
    end
  end
end

require 'reapal/railtie' if defined?(::Rails)
