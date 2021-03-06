# coding: utf-8
require 'reapal_helper'

RSpec.describe '充值查询' do
  it '成功' do
    result = client.deposit_query('5a1aa99bcd5dbb8d49000001')

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end

  it '订单不存在，失败' do
    result = client.deposit_query('adsfafafadf23424')

    expect(result[:result]).to eq('F')
    expect(result[:error_code]).to eq('0208')
  end
end
