# coding: utf-8
require 'reapal_helper'

RSpec.describe '发标' do
  context 'version3.0' do
    let(:tender_no) { Reapal::Utils.gen_flow_id }
    let(:name) { '个人借款迁移' }
    let(:contract) { 'RB180302QP1JJUEJ' }

    it '迁移历史标的' do
      result = client.tender_history_apply(Reapal::Utils.gen_flow_id,
                                           tender_no,
                                           name,
                                           2000,
                                           1,
                                           0,
                                           '1',
                                           1,
                                           '2',
                                           Time.now + 24 * 3600,
                                           Time.now + 3600 * 24,
                                           '01',
                                           contract)

      puts result[:data]

      expect(result[:result]).to eq 'S'
    end
  end
end
