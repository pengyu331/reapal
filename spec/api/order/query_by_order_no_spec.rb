# coding: utf-8
require 'reapal_helper'

RSpec.describe '订单号查询' do
  context "成功" do
    it '撤标' do
      #发标
      tender_no = borrower_tender_apply_flow_id_02

      flow_id = Reapal::Utils.gen_flow_id

      #投标
      result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                          tender_no,
                          100,
                          nil,
                          investor_contract)

      investor_tender_flow_id = result[:data][:orderNo]

      #撤标
      client.tender_all_cancel(flow_id,
                                tender_no,
                                investor_tender_flow_id)
      #撤标查询
      result = client.query_by_flow_id( flow_id, :tender_cancel )

      expect(result[:result]).to eq("S")
      expect(result[:data][:resultCode]).to eq('0000')


    end

    it '满标' do
      #1满标操作
      flow_id = tender_finish_02

      result = client.query_by_flow_id( flow_id, :tender_finish )

      expect(result[:result]).to eq("S")
      expect(result[:data][:resultCode]).to eq('0000')
    end

    it '还款' do
      #1满标操作
      #2.还款操作
      flow_id = tender_refund_01
      result = client.query_by_flow_id( flow_id, :tender_refund)

      expect(result[:result]).to eq("S")
      expect(result[:data][:resultCode]).to eq('0000')
    end

    it '债转' do
      flow_id = tender_transfer_01
      result = client.query_by_flow_id( flow_id, :tender_transfer)

      expect(result[:result]).to eq("S")
      expect(result[:data][:resultCode]).to eq('0000')
    end
  end

  context 'version3.0 ' do
    it '撤标查询成功' do
      flow_id = '5a735e1ccd5dbb7513000001'
      result = client.query_by_flow_id( flow_id, :tender_cancel )

      puts result[:data]
      expect(result[:result]).to eq("S")
      expect(result[:data][:resultCode]).to eq('0000')
    end

    it '查询满标' do
      flow_id = '5a736b10cd5dbbb923000003'
      result = client.query_by_flow_id( flow_id, :tender_finish )

      puts result[:data]
      expect(result[:result]).to eq("S")
      expect(result[:data][:resultCode]).to eq('0000')
    end
  end
  
end
