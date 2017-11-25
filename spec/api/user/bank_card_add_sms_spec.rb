# coding: utf-8
require 'reapal_helper'

RSpec.describe '一键绑卡申请' do
  let(:bank_code) {'icbc'}
  let(:bank_account_no) {'6217230200001702234'}
  let(:account_province) {'北京'}
  let(:account_city) {'北京'}
  let(:branch) {'北京分行'}
  let(:subbranch) {'北通苑支行'}
  let(:mobile_phone) {'15112344321'}

  it '成功'

  it '未填手机号，失败'

  it '用户已绑卡，失败'

end
