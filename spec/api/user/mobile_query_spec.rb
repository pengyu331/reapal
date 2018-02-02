# coding: utf-8
require 'reapal_helper'

RSpec.describe '手机号查询' do
  it '签约用户，查询成功' do
    contract = 'RB180202OPH5JH5C'

    result = client.mobile_query(contract)

    puts result[:data]
  end
end
