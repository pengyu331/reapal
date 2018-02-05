# coding: utf-8
require 'reapal_helper'

RSpec.describe '关闭标的' do
  let(:tender_no) { '5a71a611cd5dbb9f6f000002' }

  it '成功' do
    result = client.tender_close(tender_no)

    expect(result[:result]).to eq('S')
  end
end
