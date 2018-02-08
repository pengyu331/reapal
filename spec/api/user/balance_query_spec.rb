# coding: utf-8
require 'reapal_helper'

RSpec.describe '查询个人余额' do
  it '成功' do
    result = client.balance_query(test_contracts)

    expect(result[:result]).to eq('S')
    expect(result[:data][:totalAmount]).not_to eq(nil)
  end

  it '在没有签约的情况下，失败' do
    result = client.balance_query('test')

    expect(result[:result]).to eq('F')
  end

  context 'version 3.0' do
    it '查询投资人001' do
      contract = invester_001[:contract]
      result = client.balance_query(contract)

      puts "contract: #{contract}"
      puts result[:data]

      expect(result[:result]).to eq('S')
      expect(result[:data][:totalAmount]).not_to eq(nil)
    end
    
  end
  
end
