# coding: utf-8
require 'reapal_helper'

RSpec.describe '一键债权转让' do

  it '首次债转,成功' do
    # 1. 发标
    tender_no = borrower_tender_apply_flow_id_02
    # 2. 一键投标

    result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                        tender_no,
                        100,
                        nil,
                        investor_contract_01)
    # 3.一键债转
    result = client.tender_onekey_single_transfer(Reapal::Utils.gen_flow_id,
                                                  tender_no,
                                                  100,
                                                  100,
                                                  investor_contract_01,
                                                  investor_contract,
                                                  1,
                                                  result[:data][:orderNo],
                                                  ''
                                                  )

    expect(result[:result]).to eq('S')

  end


 it "bangka" do
investor_deposit_01
 end


  it '二次债转,成功' do
    # 1. 发标
    tender_no = borrower_tender_apply_flow_id_02
    # 2. 一键投标

    result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                        tender_no,
                        100,
                        nil,
                        investor_contract_01)
    # 3.一键债转
    result0 = client.tender_onekey_single_transfer(Reapal::Utils.gen_flow_id,
                                                  tender_no,
                                                  100,
                                                  100,
                                                  investor_contract_01,
                                                  investor_contract,
                                                  1,
                                                  result[:data][:orderNo],
                                                  ''
                                                  )

    result = client.tender_onekey_single_transfer(Reapal::Utils.gen_flow_id,
                                                  tender_no,
                                                  100,
                                                  100,
                                                  investor_contract,
                                                  investor_contract_02,
                                                  2,
                                                  '',
                                                  result0[:data][:orderNo]
                                                  )





    expect(result[:result]).to eq('S')

  end

end
