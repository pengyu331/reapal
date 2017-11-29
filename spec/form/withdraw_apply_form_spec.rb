# coding: utf-8
require 'reapal_helper'

RSpec.describe '提现申请' do
  it '成功' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.withdraw_apply_form(test_contracts, Reapal::Utils.gen_flow_id, 100, 1, '', '')

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

    path = "tmp/spec_withdraw_apply.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close

    puts "测试 html 导入到：#{path}"
  end
end
