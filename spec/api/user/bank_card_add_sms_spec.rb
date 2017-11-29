# coding: utf-8
require 'reapal_helper'

RSpec.describe '一键绑卡申请' do
  let(:bank_code) { 'icbc' }
  let(:bank_account_no) { '6217230200001702234' }
  let(:account_province) { '北京' }
  let(:account_city) { '北京' }
  let(:branch) { '北京分行' }
  let(:subbranch) { '北通苑支行' }
  let(:mobile_phone) { '15112344321' }

  it '成功' do
    result = client.bank_card_add_sms(Reapal::Utils.gen_flow_id,
                                      test_contracts_2,
                                      bank_code,
                                      bank_account_no,
                                      account_province,
                                      account_city,
                                      branch,
                                      subbranch,
                                      mobile_phone)

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end

  it '因用户已绑卡，失败' do
    result = client.bank_card_add_sms(Reapal::Utils.gen_flow_id,
                                      test_contracts,
                                      bank_code,
                                      bank_account_no,
                                      account_province,
                                      account_city,
                                      branch,
                                      subbranch,
                                      mobile_phone)

    expect(result[:result]).to eq('F')
    expect(result[:error_code]).to eq('0341')
  end
end
