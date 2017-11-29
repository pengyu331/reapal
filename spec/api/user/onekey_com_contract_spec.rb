# coding: utf-8
require 'reapal_helper'

RSpec.describe '企业一键签约' do
  it '签约成功' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.onekey_com_contract(Reapal::Utils.gen_flow_id,
                                        '李大海',
                                        '130627123652149856',
                                        '测试公司01',
                                        '839639295',
                                        '20141230',
                                        '20200220',
                                        '15912344321',
                                        'http://127.0.0.1',
                                        'http://127.0.0.1',
                                        '123456@reapal.com')

    expect(result[:result]).not_to eq('P')

    if result[:result] == 'S'
      expect(result[:data][:resultCode]).to eq('0002')
    elsif result[:result] == 'F'
      expect(result[:error_code]).to eq('0163')
    end
  end

  it '已签约手机号，不同组织代码，失败' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.onekey_com_contract(Reapal::Utils.gen_flow_id,
                                        '甄有钱',
                                        '500627123652149856',
                                        '测试公司02',
                                        '889639295',
                                        '20141230',
                                        '20200220',
                                        '15912344321',
                                        'http://127.0.0.1',
                                        'http://127.0.0.1',
                                        '123456@reapal.com')

    expect(result[:result]).to eq('F')
    expect(result[:data][:resultCode]).to eq('0130')
  end

  it '申请成功，等待审核' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.onekey_com_contract(Reapal::Utils.gen_flow_id,
                                        '甄有钱',
                                        '500627123652149856',
                                        '测试公司03',
                                        '889639288',
                                        '20141230',
                                        '20200220',
                                        '15900000000',
                                        'http://127.0.0.1',
                                        'http://127.0.0.1',
                                        '123456@reapal.com')

    expect(result[:result]).not_to eq('S')

    if result[:result] == 'P'
      expect(result[:data][:resultCode]).to eq('0000')
    elsif result[:result] == 'F'
      expect(result[:error_code]).to eq('0525')
    end
  end

  it '签约被拒绝' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.onekey_com_contract(Reapal::Utils.gen_flow_id,
                                        '李开',
                                        '500627123652149856',
                                        '测试公司04',
                                        '889639277',
                                        '20141230',
                                        '20200210',
                                        '15900000001',
                                        'http://127.0.0.1',
                                        'http://127.0.0.1',
                                        '123456@reapal.com')

    expect(result[:result]).to eq('F')
    expect(result[:error_code]).to eq('0525')
  end
end
