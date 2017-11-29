# coding: utf-8
require 'reapal_helper'

RSpec.describe '绑卡查询' do
  it '用户未绑卡, 失败' do
    result = client.bind_card_query(test_contracts_2)

    expect(result[:error_code]).to eq('9065')
  end

  it '业务类型非提现(type 不为 W), 失败' do
    result = client.bind_card_query(test_contracts, 'A')

    expect(result[:error_code]).to eq('9064')
  end

  it '成功' do
    result = client.bind_card_query(test_contracts)

    expect(result[:result]).to eq('S')
    expect(result[:data][:bankCards]).not_to eq(nil)
  end 
end
