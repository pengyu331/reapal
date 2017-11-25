# coding: utf-8
require 'reapal_helper'

RSpec.describe '绑卡查询' do
  it '用户未绑卡, 失败' do
    result = client.bind_query(test_contracts_2)

    expect(result[:success]).to eq(false)
  end

  it '业务类型非提现(type 不为 W), 失败' do
    result = client.bind_query(test_contracts, "A")

    expect(result[:success]).to eq(false)
  end

  it '成功' do
    result = client.bind_query(test_contracts)
    
    expect(result[:success]).to eq(true)
    expect(result[:bank_cards]).not_to eq(nil)
  end
end
