# coding: utf-8
require 'reapal_helper'

RSpec.describe '历史标的信息修改' do
  let(:flow_id1) {Reapal::Utils.gen_flow_id}
  let(:flow_id2) {Reapal::Utils.gen_flow_id}
  let(:tender_no) {"5a434e13cd5dbb9c12000028"}
  let(:fee_amount) {0}
  let(:refund_term) {"8"}
  let(:tender_type) {"00"}
  let(:debit_contracts) {"RB171126ATA3S2DK"}
  let(:guarant_contract) {""}
  let(:commissioned_contract) {""}
  let(:user_type) {"02"}

  let(:contracts) {}
  it '修改成功' do

    client.set_history_user_type(flow_id1, debit_contracts, user_type)

    result = client.history_tender_info_modify(flow_id2,
                                                tender_no,
                                                fee_amount,
                                                refund_term,
                                                tender_type,
                                                debit_contracts,
                                                guarant_contract,
                                                commissioned_contract,
                                                user_type
                                              )
    puts result[:data]
    puts "flow_id2: #{flow_id2}"

    expect(result[:result]).to eq("S")
    expect(result[:data][:resultCode]).to eq("0000")
  end

end
