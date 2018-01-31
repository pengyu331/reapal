# coding: utf-8
require 'reapal_helper'

RSpec.describe '发标确认' do
  it '成功' do
    result = client.tender_apply_confirm_form(Reapal::Utils.gen_flow_id, '5a699c2acd5dbbf378000002',
    'http://127.0.0.1',
    'http://127.0.0.1'
    )

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

    path = "tmp/spec_tender_apply_confirm_form.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close

    puts "测试 html 导入到：#{path}"
  end
end
