# coding: utf-8
require 'reapal_helper'

RSpec.describe '会员缴费查询' do
  it '成功' do
    result = client.member_payment_query('5a74058fcd5dbbb860000001')

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end
end
