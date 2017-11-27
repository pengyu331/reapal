# coding: utf-8
require 'reapal_helper'

RSpec.describe '撤标' do
  let(:tender_no) {Reapal::Utils.gen_flow_id}
  let(:tender_name) {'KOOOOOO'}
  let(:debit_contracts) {test_contracts}
  let(:guarant_contract) {''}

  it "成功撤单，撤销满标前处理中订单"

  it "成功撤单，撤销满标前成功的订单"

  it "投标撤销后，再次撤标，失败"  

  it "撤标订单号不存在，失败" do
    flow_id = Reapal::Utils.gen_flow_id
    result = client.tender_all_cancel(flow_id, tender_no, tender_no)

    expect(result[:result]).to eq('F')
  end
end
