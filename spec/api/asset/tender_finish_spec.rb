# coding: utf-8
require 'reapal_helper'

RSpec.describe '满标' do


  it "成功" do
    #1.发标
      #A发标 100元
      borrower_tender_apply_01
    #2.投标
      #B投标 30元
      investor_tender_order_no_01
      #C投标 70元
      investor_tender_order_no_02

    #3.满标

    debit_details = [{
      serialNo: Reapal::Utils.gen_flow_id,
      payeeContracts: borrower_contract,
      amount: 100,
      remark: ''
      }]

    invest_details = [{
      serialNo: Reapal::Utils.gen_flow_id,
      investContracts: investor_contract,
      payeeContracts: borrower_contract,
      amount: 30,
      remark: ''
      },
      {
        serialNo: Reapal::Utils.gen_flow_id,
        investContracts: investor_contract_01,
        payeeContracts: borrower_contract,
        amount: 70,
        remark: ''
        }]

    result = client.tender_finish(Reapal::Utils.gen_flow_id,
                                  'DZH000011',
                                  borrower_contract,
                                  debit_details,
                                  invest_details)


    expect(result[:result]).to eq("S")
    expect(result[:data][:resultCode]).to eq('0000')

  end

end
