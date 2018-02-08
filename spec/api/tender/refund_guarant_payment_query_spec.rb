# coding: utf-8
require 'reapal_helper'

RSpec.describe '借款人还代偿款查询' do

  it '成功' do
    flow_id = '5a73d036cd5dbb4850000001'
    result = client.refund_guarant_payment_query(flow_id)

    puts "flow_id: #{flow_id}"
    puts result[:data]

    expect(result[:result]).to eq('S')
    expect(result[:flow_id]).to eq(flow_id)
  end
end
