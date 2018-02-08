# coding: utf-8
require 'reapal_helper'

RSpec.describe '还款' do

  it '成功' do
    tender_no = '5a7353eacd5dbb5908000002'
    serial_no = Reapal::Utils.gen_flow_id

    debit_details = [{
      serialNo: serial_no,
      payeeContracts: invester_002[:contract],
      tradeAmount: 400.2,
      feeAmount: 0,
      defAmount: 0,
      amount: 400,
      intAmt: 0.2,
      remark: ''
    }]

    flow_id = Reapal::Utils.gen_flow_id
    result = client.tender_refund_form(
      flow_id,
      tender_no,
      borrower_141[:contract],
      debit_details,
      1,
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

    path = "tmp/spec_tender_refund_form.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close
    puts "flow_id: #{flow_id}"
    puts "serial_no:serial_no #{serial_no}"
    puts "测试 html 导入到：#{path}"

  end

end
