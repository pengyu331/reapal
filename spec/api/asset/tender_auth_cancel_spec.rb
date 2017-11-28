# coding: utf-8
require 'reapal_helper'

RSpec.describe '标的授权取消操作' do


  it '标的业务授权--投标，还款，债转' do
    form_tender_invest_auth
    form_tender_refund_auth
    form_tender_transfer_auth
  end

  it '投标取消成功, （记得先跑上面的授权测试，手动授权）' do

    #1.签约新用户
    # investor_contract_02
    #2. 设置新密码
      #跑spec，已完成
    #3. 标的授权操作
      #跑spec，已完成

    #查询
    client.tender_auth_query(Reapal::Utils.gen_flow_id, investor_contract_02)

    #4. 标的授权取消操作
    result = client.tender_auth_cancel(Reapal::Utils.gen_flow_id, investor_contract_02, '02')

    expect(result[:result]).to eq('S')
    expect(result[:data][:services]).to eq('02')
    # expect(result[:data][:contracts]).to eq(borrower_contract)
  end

  it '还款取消成功, （记得先跑上面的授权测试，手动授权）' do


    #查询
    client.tender_auth_query(Reapal::Utils.gen_flow_id, investor_contract_02)

    #4. 标的授权取消操作
    result = client.tender_auth_cancel(Reapal::Utils.gen_flow_id, investor_contract_02, '03', 'tendorApply002')

    expect(result[:result]).to eq('S')
    expect(result[:data][:services]).to eq('03')
    # expect(result[:data][:contracts]).to eq(borrower_contract)
  end

  it '债转取消成功, （记得先跑上面的授权测试，手动授权）' do

    #查询
    client.tender_auth_query(Reapal::Utils.gen_flow_id, investor_contract_02)

    #4. 标的授权取消操作
    result = client.tender_auth_cancel(Reapal::Utils.gen_flow_id, investor_contract_02, '04')

    expect(result[:result]).to eq('S')
    expect(result[:data][:services]).to eq('04')
    # expect(result[:data][:contracts]).to eq(borrower_contract)
  end
end
