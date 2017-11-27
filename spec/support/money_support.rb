# coding: utf-8

# money相关

module MoneySupport

  def investor_deposit
    result = client.deposit_apply_api(Reapal::Utils.gen_flow_id,
                                      investor_contract,
                                      '6217230200001702334',
                                      '王投资',
                                      '421181198608283284',
                                      Faker::PhoneNumber.cell_phone,
                                      2000,
                                      0,
                                      'd',
                                      'e',
                                      'http://127.0.0.1' )

    if result[:result] == "S"
      client.deposit_confirm_api(result[:data][:orderNo],
                                        investor_contract,
                                        '123456',
                                        '王',
                                        'http://127.0.0.1')
    end

  end

end
