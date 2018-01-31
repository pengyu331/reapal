
require 'reapal_helper'

RSpec.describe '银行卡绑定form' do
  let(:contract) { 'RB1801256YGXNBS3' }
  it '绑定成功' do
    result = client.bind_bank_card_form(Reapal::Utils.gen_flow_id,
                                        contract,
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

    path = 'tmp/spec_bind_bank_card_form.html'
    fp = File.open(path, 'w+')
    fp.write html
    fp.close

    puts "测试 html 导入到：#{path}"
  end
end
