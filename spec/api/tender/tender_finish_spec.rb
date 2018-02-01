# coding: utf-8
require 'reapal_helper'

RSpec.describe '满标' do

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

  it '满标' do
    fee_details = [{
      serialNo: Reapal::Utils.gen_flow_id,
      payeeContracts: 'R100000000532891',
      amount: 0.0,
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

  it '借款141的标的满标' do
    serial_no1 = Reapal::Utils.gen_flow_id
    serial_no2 = Reapal::Utils.gen_flow_id

    invest_details = [
      { serialNo: serial_no1,
        investContracts: invester_001[:contract],
        amount: 500,
        remark: '' },
      { serialNo: serial_no2,
        investContracts: invester_002[:contract],
        amount: 500,
        remark: '' },
    ]

    flow_id = Reapal::Utils.gen_flow_id

    result = client.tender_finish(flow_id,
                                  '5a7353eacd5dbb5908000002',
                                  borrower_141[:contract],
                                  invest_details)
    
    puts "serial_no1: #{serial_no1}"
    puts "serial_no2: #{serial_no2}"
    puts "flow_id: #{flow_id}"
    puts result[:data]
    expect(result[:result]).to eq("S")
    expect(result[:data][:resultCode]).to eq('0000')
  end
end
