# coding: utf-8
require 'reapal_helper'

RSpec.describe '企业迁移用户激活' do
  it '修改成功' do
    flow_id = Reapal::Utils.gen_flow_id
    contract = 'RC180319218ZCPLK'
    result = client.com_uploading_info_form(flow_id, contract, '', '')

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

    path = "tmp/spec_com_uploading_info.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close
    puts "flow_id: #{flow_id}"
    puts "测试 html 导入到：#{path}"
  end

end
