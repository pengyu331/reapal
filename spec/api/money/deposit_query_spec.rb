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

  context 'version 3.0' do
    it '查询投资人001的一笔充值记录' do
      deposit_flow_id = '5a74382dcd5dbbc001000001'
      result = client.deposit_query(deposit_flow_id)

      puts "deposit_flow_id: #{deposit_flow_id}"
      puts result[:data]

      expect(result[:result]).to eq('S')
      expect(result[:data][:resultCode]).to eq('0000')
    end
  end
  
end
