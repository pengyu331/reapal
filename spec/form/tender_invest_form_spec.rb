# coding: utf-8
require 'reapal_helper'

RSpec.describe '投标' do

  let(:tender_no) {Reapal::Utils.gen_flow_id}
  let(:tender_name) {'KOOOOOO'}
  let(:debit_contracts) {test_contracts}
  let(:guarant_contract) {''}

  it '成功' do

    #1.发标
    flow_id = Reapal::Utils.gen_flow_id
    result = client.tender_apply(flow_id, tender_no, tender_name, '10000.00',
                                 '8.2', '12', '1', '20170303', '20170103', debit_contracts,
                                 guarant_contract, '01', "今日新标A")

    #2.投标
    result = client.find_trade_password(Reapal::Utils.gen_flow_id, tender_no, "100", '4', '', '', '', '01')


    result = result[:form_data]

    html = <<-EOF
          <form action="#{result[:url]}" method="#{result[:method]}">
            <p>First name: <input type="text" name="merchant_id" value="#{result[:merchant_id]}"/></p>
            <p>Last name: <input type="text" name="encryptkey" value="#{result[:encryptkey]}"/></p>
            <p>Last name: <input type="text" name="data" value="#{result[:data]}"/></p>
            <input type="submit" value="Submit" />
          </form>
              EOF

    path = "tmp/spec_tender_apply.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close

    puts "测试 html 导入到：#{path}"
  end

end
