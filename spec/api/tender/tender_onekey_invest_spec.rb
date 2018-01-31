# coding: utf-8
require 'reapal_helper'

RSpec.describe '一键投标' do
  let(:tender_no) {'DZH0000000230'}
  let(:tender_name) {'DZH'}

  it '成功' do
    investor_deposit #充值2000

    result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                        tender_no,
                        2000,
                        200,
                        investor_contract,
                        )

    expect(result[:result]).not_to eq('F')

    if result[:result] == 'S'
      expect(result[:data][:resultCode]).to eq('0000')
    elsif result[:result] == 'P'
      expect(result[:error_code]).to eq('0537')
    end

  end

  it "金额 <= 0 , 失败" do
    investor_deposit #充值2000

    result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                        tender_no,
                        -20,
                        0,
                        investor_contract,
                        )

    expect(result[:result]).to eq('P')
    expect(result[:error_code]).to eq('9001')
  end


  context '投资001' do
    let(:tender) { '5a699c2acd5dbbf378000002' }
    let(:contracts) { 'RB1801256YGXNBS3' }

    it '投借款141的标' do
      result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                                           tender,
                                           100,
                                           nil,
                                           contracts)
    end
  end
  
end
