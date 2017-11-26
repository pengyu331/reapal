# coding: utf-8
require 'reapal_helper'

RSpec.describe '发标' do
  let(:tender_no) {'DZH0000000230'}
  let(:tender_name) {'DZH'}

  it '成功' do
    result = client.tender_apply(Reapal::Utils.gen_flow_id,
                        tender_no,
                        tender_name,
                        10000, 12,
                        6, 1,
                        (Time.now + 180 * 24 * 3600).strftime('%Y%m%d'),
                        (Time.now + 180 * 24 * 3600).strftime('%Y%m%d'),
                        borrower_contract)

    expect(result[:result]).not_to eq('P')

    if result[:result] == 'S'
      expect(result[:data][:resultCode]).to eq('0000')
    elsif result[:result] == 'F'
      expect(result[:error_code]).to eq('0501')
    end

  end

  it "金额 <= 0 , 失败"

  it "投标截止日期大于还款日期，失败"

end
