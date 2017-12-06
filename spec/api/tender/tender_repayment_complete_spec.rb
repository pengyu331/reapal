# coding: utf-8
require 'reapal_helper'

RSpec.describe '更新还款计划' do

  it '成功' do
    #1. 满标
    #1.一键还款授权
       #借款人必须一键还款授权,跑spec，borrower_contract王借款已经授权成功
     #1.1 借款人发标 200元，返回标的号

     #2.投资人投标
     # investor_01张投资投标 50，王投资投标 150
     tender_no = investor_tender_flow_id_04

     #3 满标

     debit_details = [{
       serialNo: Reapal::Utils.gen_flow_id,
      payeeContracts: borrower_contract,
       amount: 200,
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
      periods: 6,
      projPrincipal: 200,
      projInterest: 0,
      projPoundage: 0,
      projAmount: 200,
      projTime: Time.now
    }]

    client.tender_repayment_project(flow_id, tender_no, project_details)


    #3 更新还款计划
    flow_id_complete = Reapal::Utils.gen_flow_id
    result = client.tender_repayment_complete(flow_id_complete,
                                              tender_no,
                                              6,
                                              180,
                                              10,
                                              0,
                                              190,
                                              Time.now+5*24*3600)


    expect(result[:result]).to eq('S')
    expect(result[:data][:orderNo]).to eq(flow_id_complete)
    expect(result[:data][:resultCode]).to eq("0000")
  end
end
