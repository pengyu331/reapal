# coding: utf-8
require 'reapal_helper'

RSpec.describe '企业分账查询' do
  it '成功' do
    result = client.sub_account_query('5a1c7213cd5dbbcca4000001')

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end

  it '在分账订单错误的情况下，失败' do
    result = client.withdraw_query('test')

    expect(result[:result]).to eq('F')
    expect(result[:error_code]).to eq('0313')
  end
end
