# coding: utf-8
require 'reapal_helper'

RSpec.describe '标的授权' do
  it '投资人投标授权成功' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.business_auth_form(Reapal::Utils.gen_flow_id, investor_contract_02, '02', '20201125', '', '')

    method = result[:form_method]
    result = result[:form_data]

    html = <<-EOF
<form action="#{method[:url]}" method="#{method[:method]}">
  <p>First name: <input type="text" name="merchant_id" value="#{result[:merchant_id]}"/></p>
  <p>Last name: <input type="text" name="encryptkey" value="#{result[:encryptkey]}"/></p>
  <p>Last name: <input type="text" name="data" value="#{result[:data]}"/></p>
  <input type="submit" value="Submit" />
</form>
    EOF

    path = "tmp/spec_business_auth_form.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close

    puts "测试 html 导入到：#{path}"
  end

  it '借款人一键还款授权成功' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.business_auth_form(Reapal::Utils.gen_flow_id, borrower_contract, '03', '20201125', '', '', borrower_tender_apply_flow_id_01)

    method = result[:form_method]
    result = result[:form_data]

    html = <<-EOF
<form action="#{method[:url]}" method="#{method[:method]}">
  <p>First name: <input type="text" name="merchant_id" value="#{result[:merchant_id]}"/></p>
  <p>Last name: <input type="text" name="encryptkey" value="#{result[:encryptkey]}"/></p>
  <p>Last name: <input type="text" name="data" value="#{result[:data]}"/></p>
  <input type="submit" value="Submit" />
</form>
    EOF

    path = "tmp/spec_business_auth_form_borrower_apply.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close

    puts "测试 html 导入到：#{path}"
  end

  it '投资人投标债转成功' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.business_auth_form(Reapal::Utils.gen_flow_id, investor_contract, '04', '20201125', '', '')

    method = result[:form_method]
    result = result[:form_data]

    html = <<-EOF
<form action="#{method[:url]}" method="#{method[:method]}">
  <p>First name: <input type="text" name="merchant_id" value="#{result[:merchant_id]}"/></p>
  <p>Last name: <input type="text" name="encryptkey" value="#{result[:encryptkey]}"/></p>
  <p>Last name: <input type="text" name="data" value="#{result[:data]}"/></p>
  <input type="submit" value="Submit" />
</form>
    EOF

    path = "tmp/spec_business_auth_form_investor_transfer.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close

    puts "测试 html 导入到：#{path}"
  end
end
