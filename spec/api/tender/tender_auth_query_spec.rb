# coding: utf-8
require 'reapal_helper'

RSpec.describe '授权查询' do

  it '成功' do
    flow_id = Reapal::Utils.gen_flow_id
    result = client.tender_auth_query(flow_id, borrower_141[:contract])
    
    expect(result[:result]).to eq('S')
    expect(result[:flow_id]).to eq(flow_id)
    expect(result[:data][:servicesDetail]).not_to eq(nil)
    expect(result[:data][:contracts]).to eq(borrower_141[:contract])
  end
end
