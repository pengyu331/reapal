# coding: utf-8
require 'reapal_helper'

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
                                 Time.now+5 * 360 * 24 * 3600,
                                 Time.now ,
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
                                 '8.2', '12', '1', Time.now+5 * 360 * 24 * 3600, Time.now, debit_contracts,
                                 guarant_contract, '01', "今日新标A")

    expect(result[:result]).to eq('P')
  end

  it "投标截止日期大于还款日期，失败" do
    flow_id = Reapal::Utils.gen_flow_id
    result = client.tender_apply(flow_id, tender_no, tender_name, '10000.00',
                                 '8.2', '12', '1', Time.now, Time.now + 5 * 360 * 24 * 3600, debit_contracts,
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
  context 'version3.0' do
    let(:tender_no) { Reapal::Utils.gen_flow_id }
    let(:name) {'个人借款141'}
    let(:contract) { 'RB18012506E9Q690' }

    let(:flow_id) {'5a71ad14cd5dbb6676000001'}

    it '借款吧141发标' do
      result = client.tender_apply(Reapal::Utils.gen_flow_id,
                                  tender_no,
                                  name,
                                  10000,
                                  10,
                                  100,
                                  '6',
                                  6,
                                  '1',
                                  Time.now + 5 * 360 * 24 * 3600,
                                  Time.now + 3600 * 24 * 20,
                                  '01',
                                  contract)
      
      puts result

      expect(result[:result]).not_to eq('P')

      if result[:result] == 'S'
        expect(result[:data][:resultCode]).to eq('0000')
      elsif result[:result] == 'F'
        expect(result[:error_code]).to eq('0501')
      end
    end

    it '借款吧141发标，法人001为担保方' do
      result = client.tender_apply(Reapal::Utils.gen_flow_id,
                                  tender_no,
                                  name,
                                  2000,
                                  1,
                                  0,
                                  '1',
                                  1,
                                  '2',
                                  Time.now + 24 * 3600,
                                  Time.now + 3600 * 24,
                                  '01',
                                  borrower_141[:contract],
                                  guarant_001[:contract])

      puts result[:data]

      expect(result[:result]).to eq 'S'
    end
  end
end
