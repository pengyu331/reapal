# coding: utf-8
require 'reapal_helper'

RSpec.describe '满标' do
  # let(:tender_no) {"5a195c2a3c328617ad000002"}
  # let(:tender_name) {'KOOOOOO'}
  # let(:debit_contracts) {"RB1711218SFR8G4P"} #王五 借款方
  # let(:invest_contracts_2) {test_contracts_2 }  #李四 投资方
  # let(:invest_contracts_3) {"RB1711252LHX0IZP"}  #张三  收款方
  # let(:guarant_contract) {''}
  #
  # it '成功' do
  #    flow_id = Reapal::Utils.gen_flow_id
  #    debit_details = {
  #      "serial_no": Reapal::Utils.gen_flow_id,
  #      "payee_contracts": invest_contracts_3,
  #      "amount": "10",
  #      "remark": "借款方向平台方缴纳10元手续费"
  #    }
  #
  #    invest_details = {
  #      "serial_no": Reapal::Utils.gen_flow_id,
  #      "invest_contracts": invest_contracts_2,
  #      "payee_contracts": invest_contracts_3,
  #      "amount": "1.0",
  #      "remark": "A投标1000"
  #    }
  #
  #    p "% " * 10
  #    p debit_contracts
  #    p invest_contracts_2
  #    p invest_contracts_3
  #
  #    result = client.tender_finish(flow_id, tender_no, debit_contracts, debit_details,
  #                                 invest_details )
  #
  #    expect(result[:result]).to eq('S')
  #    expect(result[:data][:orderNo]).to eq(flow_id)
  #    expect(result[:data][:resultCode]).to eq("0000")
  #  end


  it "金额 <= 0 , 失败"



end
