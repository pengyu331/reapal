# coding: utf-8
require 'reapal_helper'

RSpec.describe '一键绑卡确认' do
  it '成功' do
    result = client.bank_card_add_sms_confirm(bind_card_flow_id(test_contracts_3))

    if result[:result] == 'S'
      expect(result[:data][:resultCode]).to eq('0000')
    elsif result[:result] == 'F'
      expect(result[:error_code]).to eq('2107')
    end
  end

  it '因用户已绑卡，失败' do
    result = client.bank_card_add_sms_confirm(bind_card_flow_id(test_contracts))

    expect(result[:error_code]).to eq('2107')
  end
end
