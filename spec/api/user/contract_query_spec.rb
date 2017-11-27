# coding: utf-8
require 'reapal_helper'

RSpec.describe '签约查询' do
  let(:contract) {'5a1564efcd5dbb6f34000002'}
  let(:com_contract_2) { 'TS201505112620' }
  let(:com_contract_3) { '5a1c4ab9cd5dbb9f8f000001' }
  let(:com_contract_4) { '5a1c52abcd5dbbf492000001' }

  it '用户协议号错误，查询失败' do
    result = client.contract_query('test')

    expect(result[:result]).to eq('F')
    expect(result[:error_code]).to eq('0113')
  end

  it '个人签约用户，查询成功' do
    result = client.contract_query(contract)

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end

  it '企业签约用户，查询成功' do
    result = client.contract_query(com_contract_2)

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end

  it '企业待待审核用户，查询成功' do
    result = client.contract_query(com_contract_3)

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0003')
  end

  it '企业审核被拒用户，查询成功' do
    result = client.contract_query(com_contract_4)

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0001')
  end
end
