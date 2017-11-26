# coding: utf-8
require 'reapal_helper'

RSpec.describe '发标' do
  let(:tender_no) {'DZH0000000230'}
  let(:tender_name) {'DZH'}
  let(:debit_contracts) {"RB150303PRQZPCYI"}
  let(:guarant_contract) {''}

  it '成功' do
    borrower_tender_apply
  end

  it "金额 <= 0 , 失败"

  it "投标截止日期大于还款日期，失败"

end
