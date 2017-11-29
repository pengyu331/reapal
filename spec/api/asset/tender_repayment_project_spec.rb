# coding: utf-8
require 'reapal_helper'

RSpec.describe '还款计划' do

  it '成功' do
    #1. 满标
    #1.一键还款授权
       #借款人必须一键还款授权,跑spec，borrower_contract王借款已经授权成功
     #1.1 借款人发标 200元，返回标的号
     # tender_no = borrower_tender_apply_flow_id_01

     #2.投资人投标
     # # A充值2000
     # investor_deposit

     # investor_01张投资投标 50，王投资投标 150
     tender_no = investor_tender_flow_id_03

     #3 满标

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
       amount: 150,
       remark: ''
       },
       {
         serialNo: Reapal::Utils.gen_flow_id,
         investContracts: investor_contract_01,
         payeeContracts: borrower_contract,
         amount: 50,
         remark: ''
         }]

     client.tender_finish(Reapal::Utils.gen_flow_id,
                                   tender_no,
                                   borrower_contract,
                                   debit_details,
                                   invest_details)
    #2. 还款计划

    flow_id = Reapal::Utils.gen_flow_id

    project_details =[{
      periods:'12',
      projPrincipal: '2000',
      projInterest: '200',
      projPoundage: '0',
      projAmount: '2200',
      projTime: '20171221'
    }]

    result = client.tender_repayment_project(flow_id, Reapal::Utils.gen_flow_id, project_details)

    expect(result[:result]).to eq('S')
    expect(result[:data][:orderNo]).to eq(flow_id)
    expect(result[:data][:resultCode]).to eq("0000")
  end
end
