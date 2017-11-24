# coding: utf-8
require 'reapal_helper'

RSpec.describe '设置/修改交易密码' do
  it '成功' do
    sleep(3) # 否则会报“签约过于频繁”的错误
    new_phone = Faker::PhoneNumber.cell_phone
    result = client.find_trade_password_form(test_contracts, '', '')

    html = <<-EOF
<form action="#{result[:url]}" method="#{result[:method]}">
  <p>First name: <input type="text" name="merchant_id" value="#{result[:merchant_id]}"/></p>
  <p>Last name: <input type="text" name="encryptkey" value="#{result[:encryptkey]}"/></p>
  <p>Last name: <input type="text" name="data" value="#{result[:data]}"/></p>  
  <input type="submit" value="Submit" />
</form>
    EOF

    path = "tmp/spec_find_trade_password.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close

    puts "测试 html 导入到：#{path}"
  end
end
