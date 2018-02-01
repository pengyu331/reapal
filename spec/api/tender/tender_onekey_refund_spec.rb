# coding: utf-8
require 'reapal_helper'

RSpec.describe '一键还款' do

  it '成功'do

    #1.一键还款授权
      #借款人必须一键还款授权,跑spec，
      #因为还款授权要跟每个标一一对应，所以每次跑这个测试要先去发个新的标号，然后手动
      #去做还款授权：
      #1.先去  borrower_tender_apply_flow_id_01，修改下tender_no
      #2.然后  执行/Users/peter/reapal/spec/form/business_auth_form_spec.rb对应的还款授权部分测试，
      #3.接着  手动去还款授权
      #此时，针对新的标，borrower_contract王借款才授权成功
      #最后才可以执行下面的一键还款测试。

    #1.1 借款人发标 200元，返回标的号
    # tender_no = borrower_tender_apply_flow_id_01

    #2.投资人投标
    # investor_01张投资投标 50，王投资投标 150
    tender_no = investor_tender_flow_id_03


    # 还款授权  (见 1 )

    #3 满标

    debit_details = [{
      serialNo: Reapal::Utils.gen_flow_id,
      payeeContracts: borrower_contract,
      amount: 100,
      remark: ''
      }]

    invest_details = [{
      serialNo: Reapal::Utils.gen_flow_id,
      investContracts: investor_contract,
      payeeContracts: borrower_contract,
      amount: 150,
      remark: ''
      },
      {
        serialNo: Reapal::Utils.gen_flow_id,
        investContracts: investor_contract_01,
        payeeContracts: borrower_contract,
        amount: 50,
        remark: ''
        }]

    client.tender_finish(Reapal::Utils.gen_flow_id,
                                  tender_no,
                                  borrower_contract,
                                  debit_details,
                                  invest_details)


    #4.一键还款
    debit_details = [{
            "serialNo": Reapal::Utils.gen_flow_id,
            "payeeContracts": investor_contract,
            "amount": "150",
            "remark": "向王投资还款150"
        },
        {
            "serialNo": Reapal::Utils.gen_flow_id,
            "payeeContracts": investor_contract_01,
            "amount": "50",
            "remark": "向张投资还款50"
        }]

    result = client.tender_onekey_refund(Reapal::Utils.gen_flow_id,
                                         tender_no,
                                         borrower_contract,
                                         debit_details
                                         )

    expect(result[:result]).to eq("S")
    expect(result[:data][:resultCode]).to eq('0000')
  end

  it '借款人141一键还款100元' do
    tender_no = '5a71f90ecd5dbb21a8000002'

    debit_details = [{
      serialNo: Reapal::Utils.gen_flow_id,
      payeeContracts: invester_001[:contract],
      tradeAmount: 105.5,
      feeAmount: 0.5,
      defAmount: 0,
      amount: 100,
      intAmt: 5,
      remark: ''
    }]

    flow_id = Reapal::Utils.gen_flow_id

    result = client.tender_onekey_refund(Reapal::Utils.gen_flow_id,
                                         tender_no,
                                         1,
                                         borrower_141[:contract],
                                         debit_details
                                         )
    puts flow_id
    expect(result[:result]).to eq("S")
    expect(result[:data][:resultCode]).to eq('0000')
  end

  it '担保方代还款600.3' do
    tender_no = '5a7353eacd5dbb5908000002'
    serial_no = Reapal::Utils.gen_flow_id

    debit_details = [{
      serialNo: serial_no,
      payeeContracts: invester_001[:contract],
      tradeAmount: 600.3,
      feeAmount: 0,
      defAmount: 0,
      amount: 600,
      intAmt: 0.3,
      remark: ''
    }]

    serial_no2 = Reapal::Utils.gen_flow_id
    defray_details = [{
      serialNo: serial_no2,
      payerContracts: guarant_001[:contract],
      amount: 600.3,
      remark: ''
    }]

    flow_id = Reapal::Utils.gen_flow_id

    result = client.tender_onekey_refund(Reapal::Utils.gen_flow_id,
                                         tender_no,
                                         1,
                                         borrower_141[:contract],
                                         debit_details,
                                         [],
                                         defray_details
                                         )
    puts flow_id
    expect(result[:result]).to eq("S")
    expect(result[:data][:resultCode]).to eq('0000')
  end

end
