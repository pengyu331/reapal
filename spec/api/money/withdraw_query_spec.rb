# coding: utf-8
require 'reapal_helper'

RSpec.describe '提现查询' do
  it '成功' do
    withdraw_flow_id = '5a7453ebcd5dbb5212000001'
    result = client.withdraw_query(withdraw_flow_id)

    puts result[:data]
  end

  it '在提现订单错误的情况下，失败' do
    result = client.withdraw_query('test')

    expect(result[:result]).to eq('F')
  end
end
