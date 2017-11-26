# coding: utf-8
require 'reapal_helper'

RSpec.describe '快捷充值签约' do
  let(:id) {'421181198608283272'}
  let(:phone) {'15700069144'}
  let(:bank_card) {'6217000010027440000'}
  let(:name) {'王五'}
  let(:amount) {0.01}
  let(:charge) {0.03}
  let(:terminal_info) {'s'}
  let(:member_ip) {'s'}
  let(:notify_url) {'http://127.0.0.1'}


  it '成功' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.deposit_apply_api(Reapal::Utils.gen_flow_id, test_contracts, bank_card, name,
                                      id, phone, amount, charge, terminal_info, member_ip,
                                      notify_url)

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end

end
