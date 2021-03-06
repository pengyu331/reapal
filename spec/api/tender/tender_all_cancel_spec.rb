# coding: utf-8
require 'reapal_helper'

RSpec.describe '撤标' do
  let(:tender_no) {Reapal::Utils.gen_flow_id}

  it "成功撤单，撤销满标前处理中订单" do
    tender_no = 'DZH000001'

    borrower_tender_apply_flow_id
    result = client.tender_all_cancel(Reapal::Utils.gen_flow_id,
                                      tender_no,
                                      investor_tender_flow_id)

    expect(result[:result]).to eq("S")
    expect(result[:data][:resultCode]).to eq('0000')
  end

  it "成功撤单，撤销满标前成功的订单"

  it "投标撤销后，再次撤标，失败" do
    tender_no = 'DZH000001'
    t  = investor_tender_flow_id
    result = client.tender_all_cancel(Reapal::Utils.gen_flow_id,
                                      tender_no,
                                      t)
    result = client.tender_all_cancel(Reapal::Utils.gen_flow_id,
                                      tender_no,
                                      t)

    expect(result[:result]).to eq("F")
    # expect(result[:data][:resultCode]).to eq('0000')
  end

  it "撤标订单号不存在，失败" do
    flow_id = Reapal::Utils.gen_flow_id
    result = client.tender_all_cancel(flow_id, tender_no, tender_no)

    expect(result[:result]).to eq('F')
  end
end
