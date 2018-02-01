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
    #2. 设置新密码
      #跑spec，已完成
    #3. 标的授权操作
      #跑spec，已完成

    #4. 标的授权取消操作
    result = client.tender_auth_cancel(Reapal::Utils.gen_flow_id, investor_contract_02, '02')

    expect(result[:result]).not_to eq('P')

    if 'S' == result[:result]
      expect(result[:data][:services]).to eq('02')
    elsif 'F' == result[:result]
      expect(result[:error_code]).to eq('1321')
    end
  end

  it '还款取消成功, （记得先跑上面的授权测试，手动授权）' do
    #4. 标的授权取消操作
    result = client.tender_auth_cancel(Reapal::Utils.gen_flow_id, investor_contract_02, '03', 'tendorApply002')

    if 'S' == result[:result]
      expect(result[:data][:services]).to eq('03')
    elsif 'F' == result[:result]
      expect(result[:error_code]).to eq('1321')
    end
  end

  it '债转取消成功, （记得先跑上面的授权测试，手动授权）' do
    #4. 标的授权取消操作
    result = client.tender_auth_cancel(Reapal::Utils.gen_flow_id, investor_contract_02, '04')

    if 'S' == result[:result]
      expect(result[:data][:services]).to eq('04')
    elsif 'F' == result[:result]
      expect(result[:error_code]).to eq('1321')
    end
  end

  context 'version 3.0' do
    let(:contracts) { 'RB1801256YGXNBS3' }
    it '投资001测试' do
      result = client.tender_auth_cancel(Reapal::Utils.gen_flow_id,
                                        contracts,
                                        '02')

      puts result
    end

    it '借款141取消授权一键还款' do
      flow_id = Reapal::Utils.gen_flow_id

      result = client.tender_auth_cancel(Reapal::Utils.gen_flow_id,
                                         borrower_141[:contract],
                                         '03')
      puts flow_id
      puts '*'*100
      puts result
    end
  end
end
