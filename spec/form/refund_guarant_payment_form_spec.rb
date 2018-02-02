# coding: utf-8
require 'reapal_helper'

RSpec.describe '借款人还代偿款' do
  it '法人001' do
    flow_id = Reapal::Utils.gen_flow_id
    tender_no = '5a7353eacd5dbb5908000002'

    result = client.refund_guarant_payment_form(flow_id,
                                                tender_no,
                                                600.3,
                                                0,
                                                guarant_001[:contract],
                                                'http://127.0.0.1',
                                                'http://127.0.0.1')

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

    path = "tmp/spec_find_refund_guarant_payment_form.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close
    puts "flow_id: #{flow_id}"
    puts "测试 html 导入到：#{path}"
  end
end