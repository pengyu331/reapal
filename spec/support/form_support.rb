# coding: utf-8
# form相关

module FormSupport

  def form_tender_invest_auth
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.business_auth_form(Reapal::Utils.gen_flow_id, investor_contract_02, '02', '20201125', '','')

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

    path = "tmp/spec_invest_auth_form.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close

    puts "一键投标测试 html 导入到：#{path}"
  end

  def form_tender_refund_auth
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.business_auth_form(Reapal::Utils.gen_flow_id, investor_contract_02, '03', '20201125', '', '', 'tendorApply002')

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

    path = "tmp/spec_refund_auth_form.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close

    puts "一键还款测试 html 导入到：#{path}"
  end

  def form_tender_transfer_auth
    sleep(3) # 否则会报“签约过于频繁”的错误
    result = client.business_auth_form(Reapal::Utils.gen_flow_id, investor_contract_02, '04', '20201125', '','')

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

    path = "tmp/spec_transfer_auth_form.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close

    puts "一键债转测试 html 导入到：#{path}"
  end

end
