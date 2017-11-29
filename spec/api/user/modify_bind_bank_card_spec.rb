# coding: utf-8
require 'reapal_helper'

RSpec.describe '修改绑卡' do
  let(:bank_account_no) {'2234'}
  let(:bank_account_no_2) {'1122'}
  let(:account_province) {'北京'}
  let(:account_city) {'北京'}
  let(:branch) {'北京朝阳分行'}
  let(:subbranch) {'朝阳支行'}

  it '成功' do
    result = client.modify_bind_bank_card(Reapal::Utils.gen_flow_id,
                                          test_contracts,
                                          bank_account_no,
                                          account_province,
                                          account_city,
                                          branch,
                                          subbranch)

    expect(result[:result]).to eq('S')
    expect(result[:data][:resultCode]).to eq('0000')
  end

  it '卡号同绑卡不一致，失败' do
    result = client.modify_bind_bank_card(Reapal::Utils.gen_flow_id,
                                          test_contracts,
                                          bank_account_no_2,
                                          account_province,
                                          account_city,
                                          branch,
                                          subbranch)

    expect(result[:result]).to eq('F')
    expect(result[:error_code]).to eq('0362')
  end
end
