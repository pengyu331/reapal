# coding: utf-8
require 'reapal_helper'

RSpec.describe '订单号查询(单笔)' do
  context "查询成功" do
    it '发标' do
      tender_no = tender_apply_test
      result = client.query_by_single_flow_id( tender_no, :tender_apply)

      expect(result[:result]).to eq("S")
      expect(result[:data][:resultCode]).to eq('0000')

    end

    it '投标' do
      tender_no = borrower_tender_apply_flow_id_02
      flow_id = Reapal::Utils.gen_flow_id
      result = client.tender_onekey_invest(flow_id,
                                            tender_no,
                                            100,
                                            nil,
                                            investor_contract_01)

      result = client.query_by_single_flow_id(flow_id, :tender_invest)

      expect(result[:result]).to eq("S")
      expect(result[:data][:resultCode]).to eq('0000')
    end

    it '查询141发的标的' do
      flow_id = '5a71ad14cd5dbb6676000001'
      result = client.query_by_single_flow_id(flow_id, :tender_apply)

      puts result

      expect(result[:result]).to eq("S")
    end
  end

  context 'version 3.0' do
    it '查询投标' do
      tender_no = '5a7361cbcd5dbbc417000001'
      result = client.query_by_single_flow_id(tender_no, :tender_invest)

      puts result[:data]
      expect(result[:result]).to eq("S")
      expect(result[:data][:resultCode]).to eq('0000')
    end

    it '标的关闭' do
      tender_no = '5a71a611cd5dbb9f6f000002'
      result = client.query_by_single_flow_id(tender_no, :tender_apply)

      puts result[:data]
      expect(result[:result]).to eq("S")
      expect(result[:data][:resultCode]).to eq('0000')
    end
  end
  
end
