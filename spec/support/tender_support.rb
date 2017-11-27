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
                        (Time.now + 180 * 24 * 3600).strftime('%Y%m%d'),
                        (Time.now + 180 * 24 * 3600).strftime('%Y%m%d'),
                        borrower_contract)
  end


  def borrower_tender_apply_order_no
    tender_no = 'DZH000001'
    client.tender_apply(Reapal::Utils.gen_flow_id,
                        tender_no,
                        'tender_name',
                        3000, 12,
                        6, 1,
                        (Time.now + 180 * 24 * 3600).strftime('%Y%m%d'),
                        (Time.now + 180 * 24 * 3600).strftime('%Y%m%d'),
                        borrower_contract)


  end

  #投标，供撤标测试用
  def investor_tender_order_no
    return @_investor_tender_order_no if @_investor_tender_order_no
    tender_no = 'DZH000001'
    result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                        tender_no,
                        100,
                        nil,
                        investor_contract)

                        # p "*" * 20
                        # p result

    @_investor_tender_order_no = result[:data][:orderNo]
    @_investor_tender_order_no
  end

  def borrower_tender_apply_01
    tender_no = 'DZH000011'
    client.tender_apply(Reapal::Utils.gen_flow_id,
                        tender_no,
                        'tender_name',
                        100, 12,
                        6, 1,
                        (Time.now + 180 * 24 * 3600).strftime('%Y%m%d'),
                        (Time.now + 180 * 24 * 3600).strftime('%Y%m%d'),
                        borrower_contract)


  end

  def investor_tender_order_no_01

    return @_investor_tender_order_no_01 if @_investor_tender_order_no_01
    tender_no = 'DZH000011'
    result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                        tender_no,
                        30,
                        nil,
                        investor_contract)


    @_investor_tender_order_no_01 = result[:data][:orderNo]
    @_investor_tender_order_no_01
  end

  def investor_tender_order_no_02

    return @_investor_tender_order_no_02 if @_investor_tender_order_no_02
    tender_no = 'DZH000011'
    result = client.tender_onekey_invest(Reapal::Utils.gen_flow_id,
                        tender_no,
                        70,
                        nil,
                        investor_contract_01)


    @_investor_tender_order_no_02 = result[:data][:orderNo]
    @_investor_tender_order_no_02
  end
end
