# coding: utf-8
require 'reapal_helper'

RSpec.describe '快捷充值确认' do
  let(:check_code) {'123456'}
  let(:terminal_info) {'s'}
  let(:member_ip) {'127.0.0.1'}


  it '成功' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.deposit_confirm_api(deposit_apply_flow_id, test_contracts, check_code,terminal_info, member_ip)

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end

end
