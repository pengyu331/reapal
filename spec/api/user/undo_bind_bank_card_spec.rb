# coding: utf-8
require 'reapal_helper'

RSpec.describe '撤销绑卡' do
  let(:bank_account_no) { '2234' }

  it '成功' do
    result = client.undo_bind_bank_card(Reapal::Utils.gen_flow_id,
                                        test_contracts_3,
                                        bank_account_no)

    if result[:result] == 'S'
      expect(result[:data][:resultCode]).to eq('0000')
    elsif result[:result] == 'F'
      expect(result[:error_code]).to eq('9065')
    end
  end

  it '用户未绑卡，失败' do
    result = client.undo_bind_bank_card(Reapal::Utils.gen_flow_id,
                                        test_contracts_2,
                                        bank_account_no)

    expect(result[:result]).to eq('F')
    expect(result[:data][:errorCode]).to eq('9065')
  end

  context 'version3.0' do
    it '用户撤销绑卡' do
      result = client.undo_bind_bank_card(Reapal::Utils.gen_flow_id,
                                         'RB1801256YGXNBS3',
                                         '4001')

      if result[:result] == 'S'
        expect(result[:data][:resultCode]).to eq('0000')
      elsif result[:result] == 'F'
        expect(result[:error_code]).to eq('9065')
      end
    end
  end
end
