RSpec.describe PxPay::Response::Pos::Pay do
  let(:raw) do
    class Raw
      def status
        200
      end
    end
    Raw.new
  end
  it 'basic' do
    json_string = '{ "mer_trade_no": "202101230000001", "gate_trade_no": null, "px_trade_no": "PXO023892398239", "status_code": "0000", "status_message": "交易成功", "amount": 300, "trade_amount": 277, "discount_amount": 10, "px_trade_time": "20210710143259", "invo_carrier": "/NFVIAZP", "mem_card_no": "wisjnf3282o102", "pay_tool_info": { "pay_tool": 1, "tool_name": "華泰銀行", "identity": "123456******7890" }, "marketing": [ { "marketing_code": "aaaaaabbbbbbcccccc", "discount": 10 }, { "marketing_code": "aaaaaabbbbbbcccccc", "discount": 0 }, { "marketing_code": "ffffff777777dddddd", "discount": 3 } ] }'
    json_data = JSON.parse(json_string)
    res = PxPay::Response::Pos::Pay.new(json_data, raw)
    expect(res.success?).to be true
    expect(res.message).to eq('交易成功')
    expect(res.trade_number).to eq('202101230000001')
    expect(res.bank_transaction_id).to eq('PXO023892398239')
    expect(res.amount).to eq(300)
    expect(res.trade_amount).to eq(277)
    expect(res.discount_amount).to eq(10)
    expect(res.carrier).to eq('/NFVIAZP')
    expect(res.pay_tool).to eq(1)
    expect(res.pay_tool_name).to eq('華泰銀行')
    expect(res.pay_tool_identity).to eq('123456******7890')
  end
end
