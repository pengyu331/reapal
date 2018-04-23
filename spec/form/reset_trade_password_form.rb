# coding: utf-8
require 'reapal_helper'

RSpec.describe '设置/修改交易密码' do
  let(:contracts) { borrower_100[:contract] }
  it '成功' do
    result = client.reset_trade_password_form(contracts, '', '')

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

    path = "tmp/spec_reset_trade_password.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close

    puts "contracts: #{contracts}"
    puts "测试 html 导入到：#{path}"
  end
end