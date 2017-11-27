# coding: utf-8
require 'reapal_helper'

RSpec.describe '提现查询' do
  it '成功'

  it '在提现订单错误的情况下，失败' do
    result = client.withdraw_query('test')

    expect(result[:result]).to eq('F')
  end
end
