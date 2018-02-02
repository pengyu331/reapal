# coding: utf-8
require 'reapal_helper'

RSpec.describe '企业分账查询' do
  it '成功' do
    result = client.sub_account_query(sub_account_flow_id)

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end

  it '在分账订单错误的情况下，失败' do
    result = client.withdraw_query('test')

    expect(result[:result]).to eq('F')
    expect(result[:error_code]).to eq('0313')
  end

  context 'version 3.0' do
    it '查询给投资人001分账' do
      flow_id = '5a744ef1cd5dbb980d000001'

      result = client.sub_account_query(flow_id)

      puts result[:data]

      expect(result[:result]).to eq('S')
      expect(result[:data][:resultCode]).to eq('0000')
    end
  end
end
