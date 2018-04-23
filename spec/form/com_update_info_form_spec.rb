# coding: utf-8
require 'reapal_helper'

RSpec.describe '修改企业信息' do
  it '修改成功' do
    flow_id = Reapal::Utils.gen_flow_id
    contract = 'RC180319218ZCPLK'
    result = client.com_update_info_form(flow_id, contract, 'http://127.0.0.1', 'http://127.0.0.1')

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

    path = "tmp/spec_com_update_info.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close
    puts "flow_id: #{flow_id}"
    puts "测试 html 导入到：#{path}"
  end

end