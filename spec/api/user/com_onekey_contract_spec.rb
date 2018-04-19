# coding: utf-8
require 'reapal_helper'

RSpec.describe 'com_onekey_contract' do
  it '历史企业用户迁移' do
    result = client.com_onekey_contract(Reapal::Utils.gen_flow_id,
                                        '明亮',
                                        '130227198211171037',
                                        '1307590000',
                                        '明亮',
                                        '130227198211171037',
                                        '1307590000',
                                        '艾奇商业公司',
                                        '1308230022',
                                        Time.now - 3600 * 24 * 365 * 5,
                                        Time.now + 3600 * 24 * 365 * 5,
                                        'other',
                                        '478812340000',
                                        '02',
                                        'mingliang@aiqi.com')

    puts result[:data]

    expect(result[:result]).to eq 'S'
  end
end
