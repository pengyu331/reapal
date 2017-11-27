# coding: utf-8
require 'reapal_helper'

RSpec.describe '一键还款' do

  it '成功'
#do
#     #1.一键还款授权
#       #借款人必须一键还款授权,跑spec，borrower_contract已经授权成功
#     #1.1 发标 200元，返回标的号
#     tender_no = borrower_tender_apply_flow_id_01
#
#     #2.投标
#     # A充值2000
#     investor_deposit
#
#     # A投标100，B投标100
#     investor_tender_flow_id_03
#
#     #满标
#
#
#     #3.一键还款
#     debit_details = [{
#             "serialNo": Reapal::Utils.gen_flow_id,
#             "payeeContracts": investor_contract,
#             "amount": "100",
#             "remark": "向A还款100"
#         },
#         {
#             "serialNo": Reapal::Utils.gen_flow_id,
#             "payeeContracts": investor_contract_01,
#             "amount": "100",
#             "remark": "向B还款100"
#         }
# ]
#     result = client.tender_onekey_refund(Reapal::Utils.gen_flow_id,
#                                          tender_no,
#                                          borrower_contract,
#                                          debit_details
#                                          )
#
#     expect(result[:result]).to eq("S")
#     expect(result[:data][:resultCode]).to eq('0000')
#   end

end
