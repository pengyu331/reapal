###历史用户迁移（四要素）
# coding: utf-8
require 'reapal_helper'

RSpec.describe '历史用户迁移' do
  let(:flow_id) {Reapal::Utils.gen_flow_id}
  let(:true_name) {"张三"}
  let(:identity_id) {"622926197402279772"}
  let(:phone) {"15559882222"}
  let(:is_to_sms) {"F"}
  let(:bank_code) {"icbc"}
  let(:card_id) {"6217230200001702234"}
  let(:card_province) {"北京"}
  let(:card_city) {"北京"}
  let(:card_branch) {"北京"}
  let(:card_sub_branch) {"北京"}
  let(:user_type) {"02"}

  it '迁移成功' do
    result = client.onekey_batch_contract(flow_id,
                                          true_name,
                                          identity_id,
                                          phone,
                                          is_to_sms,
                                          bank_code,
                                          card_id,
                                          card_province,
                                          card_city,
                                          card_branch,
                                          card_sub_branch,
                                          user_type
                                        )
    puts result[:data]
    puts "flow_id: #{flow_id}"

    expect(result[:result]).to eq("S")
    expect(result[:data][:resultCode]).to eq("0000").or eq("0007")
    expect(result[:data][:bankCode]).to eq("icbc")
  end

end
