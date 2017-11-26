# coding: utf-8

# 用户相关

module UserSupport

  def investor_contract
    return @_investor_contract if @_investor_contract

    sleep(3) # 否则会报“签约过于频繁”的错误

    name='王投资'
    id='421181198608283284'
    other_phone = Faker::PhoneNumber.cell_phone
    result = client.onekey_contract(Reapal::Utils.gen_flow_id,
                                    name, id, other_phone)

    @_investor_contract = result[:data][:contracts]

    @_investor_contract
  end

  def investor_bind_card
    result = client.bank_card_add_sms(Reapal::Utils.gen_flow_id,
                                      investor_contract,
                                      'icbc',
                                      '6217230200001702334',
                                      '北京',
                                      '北京',
                                      '北京',
                                      '北京',
                                      Faker::PhoneNumber.cell_phone)

    if result[:result] == 'S'
      client.bank_card_add_sms_confirm(result[:data][:orderNo], '123456')
    end
  end

  def borrower_contract
    return @_borrower_contract if @_borrower_contract

    sleep(3) # 否则会报“签约过于频繁”的错误

    name='王借款'
    id='421181198608283280'
    other_phone = Faker::PhoneNumber.cell_phone
    result = client.onekey_contract(Reapal::Utils.gen_flow_id,
                                    name, id, other_phone)

    @_borrower_contract = result[:data][:contracts]

    @_borrower_contract
  end

  def borrower_bind_card
    result = client.bank_card_add_sms(Reapal::Utils.gen_flow_id,
                                      borrower_contract,
                                      'icbc',
                                      '6217230200001702344',
                                      '北京',
                                      '北京',
                                      '北京',
                                      '北京',
                                      Faker::PhoneNumber.cell_phone)

    if result[:result] == 'S'
      client.bank_card_add_sms_confirm(result[:data][:orderNo], '123456')
    end
  end


  def borrower_contract_1
    return @_borrower_contract if @_borrower_contract

    sleep(3) # 否则会报“签约过于频繁”的错误

    name='刘借款'
    id='422281198608283280'
    other_phone = Faker::PhoneNumber.cell_phone
    result = client.onekey_contract(Reapal::Utils.gen_flow_id,
                                    name, id, other_phone)

    @_borrower_contract = result[:data][:contracts]

    @_borrower_contract
  end



end
