# coding: utf-8
require 'reapal_helper'

RSpec.describe '充值查询' do
  it '成功'

  it '订单不存在，失败' do
    result = client.deposit_query('adsfafafadf23424')

    expect(result[:result]).to eq('F')
  end
end
