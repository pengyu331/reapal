require 'spec_helper'
require 'faker'
require 'support/const_support'

Faker::Config.locale = 'zh-CN'

RSpec.configure do |config|
  config.include ConstSupport
end
