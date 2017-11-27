# coding: utf-8
require 'reapal_helper'

RSpec.describe '企业' do
  it '分账成功' do
    result = client.sub_account(Reapal::Utils.gen_flow_id,
                                '2',
                                [{serialNo: Reapal::Utils.gen_flow_id,
                                  payeeContracts: 'RC171128A35D86EW',
                                  amount: 10,
                                  mark: ''}] )

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end

  it '分账收款方协议号为个人协议号，失败' do
    result = client.sub_account(Reapal::Utils.gen_flow_id,
                                '2',
                                [{serialNo: Reapal::Utils.gen_flow_id,
                                  payeeContracts: 'test',
                                  amount: 10,
                                  mark: ''}] )

    expect(result[:result]).to eq('F')
    expect(result[:error_code]).to eq('1607')
  end

  it '代还款成功' do
    result = client.sub_account(Reapal::Utils.gen_flow_id,
                                '1',
                                [{serialNo: Reapal::Utils.gen_flow_id,
                                  payeeContracts: 'RC171128A35D86EW',
                                  amount: 10,
                                  mark: ''}] )

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end
end
