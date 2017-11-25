# coding: utf-8
require 'reapal_helper'

RSpec.describe '撤标' do
  let(:tender_no) {Reapal::Utils.gen_flow_id}
  let(:tender_name) {'KOOOOOO'}
  let(:debit_contracts) {test_contracts}
  let(:guarant_contract) {''}


  it "成功撤单，撤销满标前处理中订单" do
    # flow_id1 = Reapal::Utils.gen_flow_id
    #
    # result1 = client.tender_apply(flow_id1, tender_no, tender_name, '10000.00',
    #                              '8.2', '12', '1', '20170303', '20170103', debit_contracts,
    #                              guarant_contract, '01', "今日新标A")
    #
    # # flow_id = result1[:data][:orderNo]
    # flow_id = Reapal::Utils.gen_flow_id
    # result = client.tender_all_cancel(flow_id, tender_no, flow_id1)
    #
    # expect(result[:result]).to eq('S')
    # expect(result[:data][:orderNo]).to eq(flow_id)
  end

  it "成功撤单，撤销满标前成功的订单" do

  end

  it "撤标后，同一标号再次撤标，失败" do

  end

  it "撤标订单号不存在，失败" do
    flow_id = Reapal::Utils.gen_flow_id
    result = client.tender_all_cancel(flow_id, tender_no, tender_no )

    expect(result[:result]).to eq('F')
  end


end
