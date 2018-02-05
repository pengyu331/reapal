# coding: utf-8
require 'reapal_helper'

RSpec.describe '设置历史用户角色' do
  let(:contracts) { 'RB171125VTNNMM9P' }
  let(:user_type) { '02' }

  it '设置成功' do
    flow_id = Reapal::Utils.gen_flow_id
    result = client.set_history_user_type(flow_id,
                                          contracts,
                                          user_type
                                          )
    puts result[:data]
    puts "flow_id: #{flow_id}"

    if result[:data][:errorCode] == "CLOSEACC0004"

    else
      expect(result[:result]).to eq("S")
      expect(result[:data][:resultCode]).to eq("0000")
    end
  end

end
