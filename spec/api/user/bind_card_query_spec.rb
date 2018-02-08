# coding: utf-8
require 'reapal_helper'

RSpec.describe '绑卡查询' do
  it '投资人001查询' do
    result = client.bind_card_query(borrower_100[:contract])

    puts result[:data]

    expect(result[:result]).to eq('S')
    expect(result[:data][:bankCards]).not_to eq(nil)
  end
end
