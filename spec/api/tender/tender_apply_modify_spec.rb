# coding: utf-8
require 'reapal_helper'

RSpec.describe '修改标的' do
  let(:tender_no) { '5a71a611cd5dbb9f6f000002' }
  let(:tender_name) { '修改内容标的' }
  let(:money) { 1000 }
  let(:rate) { 8 }
  let(:fee_amount) { 2 }
  let(:refund_term) { 3 }
  let(:debit_term) { '3' }
  let(:debit_type) { '1' }
  let(:repay_date) { Time.now + 5 * 360 * 24 * 3600 }
  let(:expiry_date) { Time.now + 3600 * 24 * 20 }
  let(:tender_type) { '01' }
  let(:debit_contracts) { borrower_141[:contract] }

  context '信息' do
    it '修改成功' do
      result = client.tender_apply_modify(Reapal::Utils.gen_flow_id,
                                          tender_no,
                                          tender_name,
                                          money,
                                          rate,
                                          fee_amount,
                                          refund_term,
                                          debit_term,
                                          debit_type,
                                          repay_date,
                                          expiry_date,
                                          tender_type,
                                          debit_contracts)

      puts result

      expect(result[:result]).to eq 'S'
    end

    it '修改名称为流标' do
      result = client.tender_apply_modify(Reapal::Utils.gen_flow_id,
                                          '5a78044dcd5dbb1ac6000002',
                                          '个人借款-流标',
                                          money,
                                          rate,
                                          fee_amount,
                                          refund_term,
                                          debit_term,
                                          debit_type,
                                          repay_date,
                                          expiry_date,
                                          tender_type,
                                          debit_contracts)

      puts result[:data]

      expect(result[:result]).to eq 'S'
    end
  end

  context '状态' do
    let(:tender_status) { '03' }
    let(:tender_no2) { '5a71f90ecd5dbb21a8000002' }
    let(:tender_name2) { '修改状态标的' }

    it '发送还款计划' do
      project_details =[{
        periods: 1,
        projPrincipal: 100,
        projInterest: 5,
        projPoundage: 0.5,
        projAmount: 105.5,
        projTime: Time.now.strftime('%Y%m%d')
      }]

      flow_id = Reapal::Utils.gen_flow_id

      result = client.tender_repayment_project(flow_id, tender_no, project_details)

      expect(result[:result]).to eq('S')
      expect(result[:data][:orderNo]).to eq(flow_id)
      expect(result[:data][:resultCode]).to eq("0000")
    end

    it '修改状态为已放款' do
      result = client.tender_apply_modify(Reapal::Utils.gen_flow_id,
                                          tender_no2,
                                          tender_name2,
                                          money,
                                          nil,
                                          0.5, # fee_amount,
                                          '1', # refund_term,
                                          nil,
                                          nil,
                                          Time.now, # repay_date,
                                          Time.now, # expiry_date,
                                          '01',
                                          borrower_141[:contract], # debit_contracts,
                                          nil,
                                          nil,
                                          '04')

      puts result[:data]

      expect(result[:result]).to eq 'S'
    end

    it '修改为已放款' do
      tender_no3 = '5a7353eacd5dbb5908000002'

      result = client.tender_apply_modify(Reapal::Utils.gen_flow_id,
                                          tender_no3,
                                          '个人借款为已放款',
                                          100,
                                          nil,
                                          0, # fee_amount,
                                          '1', # refund_term,
                                          nil,
                                          nil,
                                          Time.now, # repay_date,
                                          Time.now, # expiry_date,
                                          '01',
                                          borrower_141[:contract], # debit_contracts,
                                          nil,
                                          nil,
                                          '03')

      puts result[:data]

      expect(result[:result]).to eq 'S'
    end
  end
end
