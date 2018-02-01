# coding: utf-8

# 标相关

module TenderSupport

  def borrower_tender_apply
    borrower_contract
    borrower_bind_card
    tender_no = 'tendorApply002'
    client.tender_apply(Reapal::Utils.gen_flow_id,
                        tender_no,
                        'tender_name',
                        10000, 12,
                        6, 1,
                        Time.now + 180 * 24 * 3600,
                        Time.now + 180 * 24 * 3600,
                        borrower_contract)
  end


  def borrower_tender_apply_flow_id
    tender_no = 'DZH000001'
    client.tender_apply(Reapal::Utils.gen_flow_id,
                        tender_no,
                        'tender_name',
                        3000, 12,
                        6, 1,
                        Time.now + 180 * 24 * 3600,
                        Time.now + 180 * 24 * 3600,
                        borrower_contract)


  end

  def borrower_tender_apply_flow_id_01
    tender_no = 'DZH111122'
    client.tender_apply(Reapal::Utils.gen_flow_id,
                        tender_no,
                        'tender_name',
                        200, 12,
                        6, 1,
                        Time.now + 180 * 24 * 3600,
                        Time.now + 180 * 24 * 3600,
                        borrower_contract)
    return tender_no  #返回标的号

  end

  def borrower_tender_apply_flow_id_02
    tender_no = Reapal::Utils.gen_flow_id
    flow_id = Reapal::Utils.gen_flow_id
    client.tender_apply(flow_id,
                        tender_no,
                        'tender_name',
                        200, 12,
                        6, 1,
                        Time.now + 180 * 24 * 3600,
                        Time.now + 180 * 24 * 3600,
                        borrower_contract)
    return tender_no   #返回标的号和订单号

  end


  def borrower_tender_apply_flow_id_02
    tender_no = Reapal::Utils.gen_flow_id
    client.tender_apply(Reapal::Utils.gen_flow_id,
                        tender_no,
                        'tender_name',
                        200, 12,
                        6, 1,
                        Time.now,
                        Time.now,
                        borrower_contract)
    return tender_no  #返回标的号

  end

  def borrower_tender_apply_flow_id_03
    flow_id = Reapal::Utils.gen_flow_id
    client.tender_apply(flow_id,
                        Reapal::Utils.gen_flow_id,
                        'tender_name',
                        200, 12,
                        6, 1,
                        Time.now,
                        Time.now,
                        borrower_contract)
    return flow_id  #返回标的号

  end

  #投标，供撤标测试用
  def investor_tender_flow_id
    return @_investor_tender_flow_id if @_investor_tender_flow_id
    tender_no = 'DZH000001'
    result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                        tender_no,
                        100,
                        nil,
                        investor_contract)

                        # p "*" * 20
                        # p result

    @_investor_tender_flow_id = result[:data][:orderNo]
    @_investor_tender_flow_id
  end

  def borrower_tender_apply_01
    tender_no = 'DZH000011'
    client.tender_apply(Reapal::Utils.gen_flow_id,
                        tender_no,
                        'tender_name',
                        100, 12,
                        6, 1,
                        (Time.now + 180 * 24 * 3600) ,
                        (Time.now + 180 * 24 * 3600) ,
                        borrower_contract)


  end

  def investor_tender_flow_id_01

    return @_investor_tender_flow_id_01 if @_investor_tender_flow_id_01
    tender_no = 'DZH000011'
    result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                        tender_no,
                        30,
                        nil,
                        investor_contract)


    @_investor_tender_flow_id_01 = result[:data][:orderNo]
    @_investor_tender_flow_id_01
  end

  def investor_tender_flow_id_02

    return @_investor_tender_flow_id_02 if @_investor_tender_flow_id_02
    tender_no = 'DZH000011'
    result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                        tender_no,
                        70,
                        nil,
                        investor_contract_01)


    @_investor_tender_flow_id_02 = result[:data][:orderNo]
    @_investor_tender_flow_id_02
  end


  #投标，一键还款用
  def investor_tender_flow_id_03

    tender_no = borrower_tender_apply_flow_id_01

    client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                                tender_no,
                                50,
                                nil,
                                investor_contract_01)

    client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                                tender_no,
                                150,
                                nil,
                                investor_contract)
    return tender_no

  end


  def investor_tender_flow_id_04

    tender_no = borrower_tender_apply_flow_id_02

    client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                                tender_no,
                                50,
                                nil,
                                investor_contract_01)

    client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                                tender_no,
                                150,
                                nil,
                                investor_contract)
    return tender_no

  end


  #满标 返回商户好
  def tender_finish
    #1.发标
    #2.投标
    tender_no = investor_tender_flow_id_04

    #3.满标
    debit_seria_no = Reapal::Utils.gen_flow_id
    debit_details = [{
      serialNo:  Reapal::Utils.gen_flow_id,
      payeeContracts: borrower_contract,
      amount: 200,
      remark: '王借款200元'
      }]

    invest_details = [{
      serialNo: debit_seria_no,
      investContracts: investor_contract,
      payeeContracts: borrower_contract,
      amount: 150,
      remark: '王投资150元'
      },
      {
        serialNo: Reapal::Utils.gen_flow_id,
        investContracts: investor_contract_01,
        payeeContracts: borrower_contract,
        amount: 50,
        remark: '张投资50元'
        }]

    res = client.tender_finish(Reapal::Utils.gen_flow_id,
                                  tender_no,
                                  borrower_contract,
                                  debit_details,
                                  invest_details)
    return debit_seria_no
  end


  #满标
  def tender_finish_01
    #1.发标
    #2.投标
    tender_no = investor_tender_flow_id_04
    p "^ ^ " * 10
    p tender_no

    #3.满标
    debit_seria_no = Reapal::Utils.gen_flow_id
    debit_details = [{
      serialNo:  Reapal::Utils.gen_flow_id,
      payeeContracts: borrower_contract,
      amount: 200,
      remark: '王借款200元'
      }]

    invest_details = [{
      serialNo: debit_seria_no,
      investContracts: investor_contract,
      payeeContracts: borrower_contract,
      amount: 150,
      remark: '王投资150元'
      },
      {
        serialNo: Reapal::Utils.gen_flow_id,
        investContracts: investor_contract_01,
        payeeContracts: borrower_contract,
        amount: 50,
        remark: '张投资50元'
        }]

    res = client.tender_finish(Reapal::Utils.gen_flow_id,
                                  tender_no,
                                  borrower_contract,
                                  debit_details,
                                  invest_details)
    return tender_no
  end


  def tender_refund
    # tender_no = tender_finish_01

    client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                                'tendorApply002',
                                10,
                                nil,
                                investor_contract)

   #一键还款
    debit_seria_no = Reapal::Utils.gen_flow_id
    debit_details = [{
            "serialNo": debit_seria_no,
            "payeeContracts": investor_contract,
            "amount": "10",
            "remark": "向王投资还款10"
        }]

    client.tender_onekey_refund(Reapal::Utils.gen_flow_id,
                                "tendorApply002",
                                borrower_contract,
                                debit_details
                                )
    return debit_seria_no
  end

  def tender_refund_01

    client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                                'tendorApply002',
                                10,
                                nil,
                                investor_contract)

   #一键还款
    debit_details = [{
            "serialNo": Reapal::Utils.gen_flow_id,
            "payeeContracts": investor_contract,
            "amount": "10",
            "remark": "向王投资还款10"
        }]

    flow_id = Reapal::Utils.gen_flow_id

    client.tender_onekey_refund(flow_id,
                                "tendorApply002",
                                borrower_contract,
                                debit_details
                                )
    return flow_id
  end


  def tender_transfer
    # 1. 发标
    tender_no = borrower_tender_apply_flow_id_02
    # 2. 一键投标

    result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                                          tender_no,
                                          100,
                                          nil,
                                          investor_contract_01)
    # 3.一键债转
    flow_id = Reapal::Utils.gen_flow_id
    client.tender_onekey_single_transfer(flow_id,
                                          tender_no,
                                          100,
                                          100,
                                          investor_contract_01,
                                          investor_contract,
                                          1,
                                          result[:data][:orderNo],
                                          ''
                                          )

    return flow_id
  end

  def tender_transfer_01
    # 1. 发标
    tender_no = borrower_tender_apply_flow_id_02
    # 2. 一键投标

    result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                                          tender_no,
                                          100,
                                          nil,
                                          investor_contract_01)
    # 3.一键债转
    flow_id = Reapal::Utils.gen_flow_id
    client.tender_onekey_single_transfer(flow_id,
                                          tender_no,
                                          100,
                                          100,
                                          investor_contract_01,
                                          investor_contract,
                                          1,
                                          result[:data][:orderNo],
                                          ''
                                          )

    return flow_id
  end

  def tender_apply_test
    # 1. 发标
    tender_no = borrower_tender_apply_flow_id_03
  end

  #满标
  def tender_finish_02
    #1.发标
    #2.投标
    tender_no = investor_tender_flow_id_04

    #3.满标
    debit_seria_no = Reapal::Utils.gen_flow_id
    debit_details = [{
      serialNo:  Reapal::Utils.gen_flow_id,
      payeeContracts: borrower_contract,
      amount: 200,
      remark: '王借款200元'
      }]

    invest_details = [{
      serialNo: debit_seria_no,
      investContracts: investor_contract,
      payeeContracts: borrower_contract,
      amount: 150,
      remark: '王投资150元'
      },
      {
        serialNo: Reapal::Utils.gen_flow_id,
        investContracts: investor_contract_01,
        payeeContracts: borrower_contract,
        amount: 50,
        remark: '张投资50元'
        }]
    flow_id = Reapal::Utils.gen_flow_id
    res = client.tender_finish(flow_id,
                              tender_no,
                              borrower_contract,
                              debit_details,
                              invest_details)
    return flow_id
  end

  def tender_apply_141_flow_id
    result = client.tender_apply(Reapal::Utils.gen_flow_id,
                                 Reapal::Utils.gen_flow_id,
                                 '个人借款',
                                  10000,
                                  5,
                                  100,
                                  6,
                                  6,
                                  1,
                                  Time.now + 5 * 360 * 24 * 3600,
                                  Time.now + 3600 * 24 * 20,
                                  '01',
                                  borrower_141[:contract])

    return result[:data][:orderNo]
  end

  def tender_141
    tender_no = Reapal::Utils.gen_flow_id
    result = client.tender_apply(Reapal::Utils.gen_flow_id,
                                 tender_no,
                                 '141个人借款',
                                 100,
                                 5,
                                 0.2,
                                 '1',
                                 1,
                                 '2',
                                 Time.now + 5 * 360 * 24 * 3600,
                                 Time.now + 3600 * 24 * 20,
                                 '01',
                                 borrower_141[:contract])

    result = client.tender_apply_confirm_form(Reapal::Utils.gen_flow_id,
                                              tender_no,
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

    path = "tmp/spec_tender_apply_confirm_form.html"
    fp = File.open(path, "w+")
    fp.write html
    fp.close

    puts "测试 html 导入到：#{path}"
  end
end
