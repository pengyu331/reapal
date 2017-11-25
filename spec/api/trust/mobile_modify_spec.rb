# coding: utf-8
require 'reapal_helper'

RSpec.describe '修改签约手机号' do
  it '成功' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    new_phone = Faker::PhoneNumber.cell_phone
    result = client.mobile_modify(test_contracts, new_phone)

    puts result.to_json
  end

end
