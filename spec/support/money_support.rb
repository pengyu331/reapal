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

  def deposit_apply_order_no
    return @order_no if @order_no

    id = '421181198608283272'
    phone = '15112344321'
    bank_card = '6217230200001702234'
    name = '王五'
    amount = 100
    charge = 0.03
    terminal_info = 's'
    member_ip = '127.0.0.1'
    notify_url = 'http://127.0.0.1'

    result = client.deposit_apply_api(Reapal::Utils.gen_flow_id, test_contracts, bank_card, name,
                                      id, phone, amount, charge, terminal_info, member_ip,
                                      notify_url)

    @order_no = result[:data][:orderNo]

    @order_no
  end

end
