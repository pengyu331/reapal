# coding: utf-8
require 'reapal_helper'

RSpec.describe '一键投标' do
  let(:tender_no) {'DZH0000000230'}
  let(:tender_name) {'DZH'}

  it '成功' do
    # result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
    #                     tender_no,
    #                     2000,
    #                     200,
    #                     investor_contract,
    #                     )
    #
    # expect(result[:result]).to eq('S')
    # expect(result[:data][:resultCode]).to eq('0000')
  end

  it "金额 <= 0 , 失败"

  it "投标截止日期大于还款日期，失败"

end
