# coding: utf-8
require 'reapal_helper'

RSpec.describe '一键绑卡重发短信' do
  it '成功' do
    client.undo_bind_bank_card(Reapal::Utils.gen_flow_id,
                               test_contracts_2,
                               '2234')
                               
    flow_id = bind_card_flow_id(test_contracts_2)

    result = client.bank_card_add_sms_again(flow_id, test_contracts_2)

    expect(result[:result]) == 'S'
    expect(result[:data][:resultCode]).to eq('0000')
  end

  it '因协议号错误，失败' do
    result = client.bank_card_add_sms_again(bind_card_flow_id('RBtest123456'), 'RBtest123456')

    expect(result[:error_code]).to eq('1404')
  end
end
