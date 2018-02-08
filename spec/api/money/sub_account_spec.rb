# coding: utf-8
require 'reapal_helper'

RSpec.describe '企业' do
  it '分账成功' do
    result = client.sub_account(Reapal::Utils.gen_flow_id,
                                '2',
                                [{serialNo: Reapal::Utils.gen_flow_id,
                                  payeeContracts: investor_contract,
                                  amount: 10,
                                  mark: ''}] )

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end

  it '分账收款方协议号为错误的协议号，失败' do
    result = client.sub_account(Reapal::Utils.gen_flow_id,
                                '2',
                                [{serialNo: Reapal::Utils.gen_flow_id,
                                  payeeContracts: 'DZ123456789232',
                                  amount: 10,
                                  mark: ''}] )

    expect(result[:result]).to eq('F')
    expect(result[:error_code]).to eq('1607')
  end

  it '代还款成功' do
    result = client.sub_account(Reapal::Utils.gen_flow_id,
                                '1',
                                [{serialNo: Reapal::Utils.gen_flow_id,
                                  payeeContracts: test_contracts,
                                  amount: 10,
                                  mark: ''}] )

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end

  context 'version' do
    it '给投资人001分账' do
      flow_id = Reapal::Utils.gen_flow_id
      serial_no = Reapal::Utils.gen_flow_id

      sub_details = [{serialNo: serial_no,
                      payeeContracts: invester_001[:contract],
                      amount: 10}]

      result = client.sub_account(flow_id,
                                  '2',
                                  sub_details)


      puts flow_id
      puts result[:data]

      expect(result[:result]).to eq 'S'
    end
  end
end
