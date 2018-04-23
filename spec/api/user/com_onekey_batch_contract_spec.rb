# coding: utf-8
require 'reapal_helper'

RSpec.describe 'com_onekey_contract' do
  it '历史企业用户迁移' do
    result = client.com_onekey_batch_contract(Reapal::Utils.gen_flow_id,
                                              '明亮',
                                              '130227198211171099',
                                              '13075900099',
                                              '明亮',
                                              '130227198211171099',
                                              '13075900099',
                                              '艾奇商业公司',
                                              '1308230099AA',
                                              Time.now - 3600 * 24 * 365 * 5,
                                              Time.now + 3600 * 24 * 365 * 5,
                                              'boc',
                                              '4788123400001',
                                              '02',
                                              'mingliang@aiqi.com',
                                              'http://127.0.0.1',
                                              'http://127.0.0.1')

    puts result[:data]

    expect(result[:result]).to eq 'S'
  end
end
