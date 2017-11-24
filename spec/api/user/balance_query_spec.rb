# coding: utf-8
require 'reapal_helper'

RSpec.describe '查询个人余额' do
  it '成功' do
    result = client.balance_query(test_contracts)

    expect(result[:success]).to eq(true)
    expect(result[:data][:total_amount]).not_to eq(nil)
  end

  it '在没有签约的情况下，失败' do
    result = client.balance_query('test')

    expect(result[:success]).to eq(false)
  end
end
