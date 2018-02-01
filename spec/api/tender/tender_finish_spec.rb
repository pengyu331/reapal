# coding: utf-8
require 'reapal_helper'

RSpec.describe '满标' do

  # it '生成标的' do
  #   tender_141
  # end

  # it '用户投标' do
  #   tender_no = '5a71f90ecd5dbb21a8000002'
  #   result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
  #                                          tender_no,
  #                                          100,
  #                                          nil,
  #                                          invester_001[:contract])

  #   expect(result[:result]).to eq("S")
  # end

  it '满标' do
    fee_details = [{
      serialNo: Reapal::Utils.gen_flow_id,
      payeeContracts: 'R100000000532891',
      amount: 0.1,
      feeType: '01',
      remark: ''
      }]
  
    invest_details = [
      { serialNo: Reapal::Utils.gen_flow_id,
        investContracts: invester_001[:contract],
        amount: 100,
        remark: '' } ]
  
    result = client.tender_finish(Reapal::Utils.gen_flow_id,
                                  '5a71f90ecd5dbb21a8000002',
                                  borrower_141[:contract],
                                  fee_details,
                                  invest_details)
  
  
    expect(result[:result]).to eq("S")
    expect(result[:data][:resultCode]).to eq('0000')
  end

  # it "成功" do
  #   #1.发标
  #     #A发标 100元
  #     borrower_tender_apply_01
  #   #2.投标
  #     #B投标 30元
  #     investor_tender_flow_id_01
  #     #C投标 70元
  #     investor_tender_flow_id_02
  
  #   #3.满标
  
  #   fee_details = [{
  #     serialNo: Reapal::Utils.gen_flow_id,
  #     payeeContracts: borrower_contract,
  #     amount: 100,
  #     remark: ''
  #     }]
  
  #   invest_details = [
  #     { serialNo: Reapal::Utils.gen_flow_id,
  #       investContracts: investor_contract,
  #       payeeContracts: borrower_contract,
  #       amount: 30,
  #       remark: '' },
  #     { serialNo: Reapal::Utils.gen_flow_id,
  #       investContracts: investor_contract_01,
  #       payeeContracts: borrower_contract,
  #       amount: 70,
  #       remark: '' } ]
  
  #   result = client.tender_finish(Reapal::Utils.gen_flow_id,
  #                                 'DZH000011',
  #                                 borrower_contract,
  #                                 debit_details,
  #                                 invest_details)
  
  
  #   expect(result[:result]).to eq("S")
  #   expect(result[:data][:resultCode]).to eq('0000')
  # end

end
