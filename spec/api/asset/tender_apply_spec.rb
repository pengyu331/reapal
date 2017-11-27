# coding: utf-8
require 'reapal_helper'

##发标借款人协议号和商户号不对应 ??哪里有啊

RSpec.describe '发标' do
  let(:tender_no) {Reapal::Utils.gen_flow_id}
  let(:tender_name) {'KOOOOOO'}
  let(:debit_contracts) {test_contracts}
  let(:guarant_contract) {''}

  it '成功' do
    result = client.tender_apply(Reapal::Utils.gen_flow_id,
                                 tender_no,
                                 tender_name,
                                 10000, 12,
                                 6, 1,
                                 (Time.now + 180 * 24 * 3600).strftime('%Y%m%d'),
                                 (Time.now + 180 * 24 * 3600).strftime('%Y%m%d'),
                                 borrower_contract)

    expect(result[:result]).not_to eq('P')

    if result[:result] == 'S'
      expect(result[:data][:resultCode]).to eq('0000')
    elsif result[:result] == 'F'
      expect(result[:error_code]).to eq('0501')
    end

  end

  it "金额 <= 0 , 失败" do
    flow_id = Reapal::Utils.gen_flow_id
    result = client.tender_apply(flow_id, tender_no, tender_name, '-10000.00',
                                 '8.2', '12', '1', '20170303', '20170103', debit_contracts,
                                 guarant_contract, '01', "今日新标A")

    expect(result[:result]).to eq('P')
  end

  it "投标截止日期大于还款日期，失败" do
    flow_id = Reapal::Utils.gen_flow_id
    result = client.tender_apply(flow_id, tender_no, tender_name, '10000.00',
                                 '8.2', '12', '1', '20160303', '20170103', debit_contracts,
                                 guarant_contract, '01', "今日新标A")


    expect(result[:result]).to eq('F')
  end

  ##借款期数为空，理应失败，富民返回成功
  # it "借款期数为空，失败" do
  #    flow_id = Reapal::Utils.gen_flow_id
  #    result = client.tender_apply(flow_id, tender_no, tender_name, '10000.00',
  #                                 '8.2', '', '1', '20180303', '20170103', debit_contracts,
  #                                 guarant_contract, '01', "今日新标A")
  #                                 p "% " * 20
  #                                 p "result: " + result[:result]
  #                                 p result[:error_code]
  #                                 p "% " * 20
  #    expect(result[:result]).to eq('F')
  #  end
end
