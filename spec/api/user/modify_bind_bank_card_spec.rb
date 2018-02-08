# coding: utf-8
require 'reapal_helper'

RSpec.describe '修改绑卡' do
  let(:bank_account_no) {'2234'}
  let(:bank_account_no_2) {'1122'}
  let(:account_province) {'北京'}
  let(:account_city) {'北京'}
  let(:branch) {'北京朝阳分行'}
  let(:subbranch) {'朝阳支行'}
  let(:bank_account_no_3) { '4001' }

  it '卡号同绑卡不一致，失败' do
    # result = client.modify_bind_bank_card(Reapal::Utils.gen_flow_id,
    #                                       test_contracts,
    #                                       bank_account_no_2,
    #                                       account_province,
    #                                       account_city,
    #                                       branch,
    #                                       subbranch)

    # expect(result[:result]).to eq('F')
    # expect(result[:error_code]).to eq('0362')
  end

  it '投资人001修改成功' do
    result = client.modify_bind_bank_card(Reapal::Utils.gen_flow_id,
                                          'RB1801256YGXNBS3',
                                          bank_account_no_3,
                                          account_province,
                                          account_city,
                                          branch,
                                          subbranch)

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end

  it '借款人100修改绑卡成功' do
    flow_id = Reapal::Utils.gen_flow_id
    result = client.modify_bind_bank_card(flow_id,
                                          borrower_100[:contract],
                                          '2234',
                                          account_province,
                                          account_city,
                                          branch,
                                          subbranch)

    puts "flow_id: #{flow_id}"

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end
end
