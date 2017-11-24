# coding: utf-8
require 'reapal_helper'

RSpec.describe '发标' do
  let(:tender_no) {'DZH0000000230'}
  let(:tender_name) {'DZH'}
  let(:debit_contracts) {"RB150303PRQZPCYI"}
  let(:guarant_contract) {''}

  it '成功' do
    flow_id = Reapal::Utils.gen_flow_id
    result = client.tender_apply(flow_id, tender_no, tender_name, '10000.00',
                                 '8.2', '12', '1', '20171102', '20170902', debit_contracts,
                                 guarant_contract, '', nil)

    expect(result[:result]).to eq('S')
    expect(result[:data][:orderNo]).to eq(flow_id)
    expect(result[:data][:resultCode]).to eq("0000")
  end

  it "金额 <= 0 , 失败" do
    result = client.tender_apply(Reapal::Utils.gen_flow_id, tender_no, tender_name, '-923.00',
                                 '8.2', '6', '1', '20180903', '20190422', debit_contracts,
                                 guarant_contract, busway='01', remark='')

    expect(result[:result]).to  eq('F')

  end

  it "投标截止日期大于还款日期，失败" do
    result = client.tender_apply(Reapal::Utils.gen_flow_id, tender_no, tender_name, '-923.00',
                                 '8.2', '6', '1', '20180903', '20170422', debit_contracts,
                                 guarant_contract, busway='01', remark='')

    expect(result[:result]).to  eq('F')
  end

end
