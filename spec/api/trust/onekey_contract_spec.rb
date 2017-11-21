# coding: utf-8
require 'reapal_helper'

RSpec.describe '个人签约' do
  let(:name) {'王五'}
  let(:id) {'421181198608283272'}
  let(:phone) {'15700069144'}

  it '成功' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.onekey_contract(Reapal::Utils.gen_flow_id,
                                    name, id, phone)

    if result[:result] == 'S'
      expect(result[:data][:contracts]).not_to eq(nil)
      expect(result[:data][:userName]).to eq(name)
      expect(result[:data][:userIdentity]).to eq(id)
      expect(result[:data][:userMobile]).to eq(phone)
    elsif result[:result] == 'F'
      expect(result[:error_code]).to eq('0130')
    end
  end

  it '不通手机号，同身份签约成功，同时手机号是第一次签约成功的手机号' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    other_phone = Faker::PhoneNumber.cell_phone
    result = client.onekey_contract(Reapal::Utils.gen_flow_id,
                                    name, id, other_phone)

    expect(result[:result]).to eq("S")
    expect(result[:data][:contracts]).not_to eq(nil)
    expect(result[:data][:userName]).to eq(name)
    expect(result[:data][:userIdentity]).to eq(id)
    expect(result[:data][:userMobile]).to eq(phone)
  end

  it '已经成功签约的手机号再次签约，失败' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.onekey_contract(Reapal::Utils.gen_flow_id,
                                    name, id, phone)

    expect(result[:result]).to eq('F')
    expect(result[:error_code]).to eq('0130')
  end

end
