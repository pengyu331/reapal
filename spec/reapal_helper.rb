require 'spec_helper'
require 'faker'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |file| require file }

Faker::Config.locale = 'zh-CN'

#Reapal.logger = Logger.new('tmp/test.log')

RSpec.configure do |config|
  config.include ConstSupport
  config.include UserSupport
  config.include TenderSupport
end
