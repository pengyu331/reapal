# coding: utf-8
require 'reapal_helper'

RSpec.describe '查询' do
  context '成功' do
    it '满标' do

      #1满标操作
      seria_no = tender_finish

      #还款计划
      # flow_id_01 = Reapal::Utils.gen_flow_id
      #
      # project_details =[{
      #   periods: 6,
      #   projPrincipal: 200,
      #   projInterest: 0,
      #   projPoundage: 0,
      #   projAmount: 200,
      #   projTime: '20180303'
      # }]
      #
      # client.tender_repayment_project(flow_id_01, tender_no, project_details)


      result = client.tender_serial_no_query( seria_no, :tender_finish )


      expect(result[:result]).to eq("S")
      expect(result[:data][:resultCode]).to eq('0000')
    end

    it '还款' do
    #1满标操作
    #2.还款操作
    seria_no = tender_refund
    result = client.tender_serial_no_query( seria_no, :tender_refund)


    expect(result[:result]).to eq("S")
    expect(result[:data][:resultCode]).to eq('0000')

    end

  end

end
