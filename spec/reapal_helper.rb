require 'spec_helper'
require 'faker'
require 'support/const_support'

Faker::Config.locale = 'zh-CN'

Reapal.logger = Logger.new('tmp/test.log')

RSpec.configure do |config|
  config.include ConstSupport
end
