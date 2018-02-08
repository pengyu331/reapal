# coding: utf-8
require 'reapal_helper'

RSpec.describe '投资关系迁移' do
  let(:flow_id) { Reapal::Utils.gen_flow_id }
  let(:contracts) { 'RB1712074JKAJYW7' }
  let(:tender_no) { '5a192c4e3c3286af1d00000b' }
  # let(:flow_id2) { Reapal::Utils.gen_flow_id }

  it '设置成功' do
    invest_details = [
      { orderNo: flow_id,
        investContracts: contracts,
        amount: 70,
        remark: '',
        applyTime: Time.now.strftime('%Y-%m-%d %H:%M:%S') }
    ]


    result = client.tender_onekey_invest_history(tender_no, invest_details)

    puts result[:data]
    puts "flow_id: #{flow_id}"
    puts "tender_no: #{tender_no}"
    # puts "flow_id2: #{flow_id2}"
    expect(result[:result]).to eq("S")
    expect(result[:data][:resultCode]).to eq("0000")
  end

end
