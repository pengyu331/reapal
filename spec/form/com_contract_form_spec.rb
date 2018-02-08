
require 'reapal_helper'

RSpec.describe '企业签约form' do
  it '企业用户个人签约' do
    # 手机端没有 h5 页面
    flow_id = Reapal::Utils.gen_flow_id
    result = client.com_contract_form(flow_id,
                                      '法人200',
                                      '130001123652149200',
                                      '测试公司200',
                                      '839639295123200',
                                      Time.now,
                                      Time.now + 5 * 360 * 24 * 3600,
                                      '13977776200',
                                      'icbc',
                                      '03',
                                      'faren200@reapal.com',
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

    path = 'tmp/spec_com_contract_form.html'
    fp = File.open(path, 'w+')
    fp.write html
    fp.close

    puts "flow_id: #{flow_id}"
    puts "测试 html 导入到：#{path}"
  end
end