# coding: utf-8
require 'reapal_helper'

RSpec.describe '手机号查询' do
  it '用户协议号错误，查询失败' do

    test_contracts_1 = "1212124324323423"
    result = client.mobile_query(test_contracts_1)

    expect(result[:success]).to eq(false)
  end

  it '签约用户，查询成功' do
    result = client.mobile_query(test_contracts)

    expect(result[:success]).to eq(true)
    expect(result[:mobile]).not_to eq(nil)
  end

end
