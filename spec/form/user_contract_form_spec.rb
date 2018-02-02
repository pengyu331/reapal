
require 'reapal_helper'

RSpec.describe '个人签约' do
  it '借款用户个人签约' do
    flow_id = Reapal::Utils.gen_flow_id
    result = client.user_contract_form(flow_id,
                                       '借款101',
                                       '110103198801010101',
                                       '02',
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

    path = 'tmp/spec_user_contract_form.html'
    fp = File.open(path, 'w+')
    fp.write html
    fp.close

    puts "flow_id: #{flow_id}"
    puts "测试 html 导入到：#{path}"
  end

  it '还款授权成功' do
    result = client.business_auth_form(Reapal::Utils.gen_flow_id,
                                       'RB1801256YGXNBS3',
                                       '02',
                                       '20180918',
                                       100,
                                       1000,
                                       'http://127.0.0.1',
                                       'http://127.0.0.1',
                                       '01',
                                       'sms=0')

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

    path = 'tmp/spec_business_auth_form.html'
    fp = File.open(path, 'w+')
    fp.write html
    fp.close

    puts "测试 html 导入到：#{path}"
  end

  it '投资用户签约' do
    result = client.user_contract_form(Reapal::Utils.gen_flow_id,
                                       '投资002',
                                       '110103197501010002',
                                       '01',
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

    path = 'tmp/spec_user_contract_form.html'
    fp = File.open(path, 'w+')
    fp.write html
    fp.close

    puts "测试 html 导入到：#{path}"

    # 协议号 RB1801256YGXNBS3
  end

  it '自动投标签约' do
    result = client.business_auth_form(Reapal::Utils.gen_flow_id,
                                       'RB1801256YGXNBS3',
                                       '02',
                                       '20180918',
                                       100,
                                       1000,
                                       'http://127.0.0.1',
                                       'http://127.0.0.1',
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

    path = 'tmp/spec_business_auth_form.html'
    fp = File.open(path, 'w+')
    fp.write html
    fp.close

    puts "测试 html 导入到：#{path}"
  end
end
