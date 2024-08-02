RSpec.describe PxPay::Response::Pos::Query do
  let(:raw) do
    class Raw
      def status
        200
      end
    end
    Raw.new
  end

  it 'not_found' do
    json_string = '{ "status_code": "xxxx", "status_message": "查無訂單", "order_type": 0, "trade_info": null }'
    json_data = JSON.parse(json_string)
    res = PxPay::Response::Pos::Query.new(json_data, raw)
    expect(res.success?).to be false
    expect(res.message).to eq('查無訂單')
    expect(res.order_type).to eq(:not_found)
  end

  it 'paid' do
    json_string = '{ "status_code": "0000", "status_message": "查詢成功", "order_type": 1, "trade_info": { "mer_trade_no": "QW20210101000032", "transaction_id": "20210304000001", "px_trade_no": "PXO023892398239", "px_trade_time": "20210304170022", "amount": 300, "trade_amount": 277, "discount_amount": 23 , "pay_status": 1, "invo_carrier": "/NFVIAZP", "pay_tool_info": { "pay_tool": 1, "tool_name": "華泰銀行", "identity": "123456******7890" } } }'
    json_data = JSON.parse(json_string)
    res = PxPay::Response::Pos::Query.new(json_data, raw)
    expect(res.success?).to be true
    expect(res.message).to eq('查詢成功')
    expect(res.trade_number).to eq('QW20210101000032')
    expect(res.order_type).to eq(:paid)
    expect(res.bank_transaction_id).to eq('PXO023892398239')
    expect(res.trade_time).to eq(Time.parse('20210304170022'))
    expect(res.amount).to eq(300)
    expect(res.trade_amount).to eq(277)
    expect(res.discount_amount).to eq(23)
    expect(res.carrier).to eq('/NFVIAZP')
    expect(res.pay_tool).to eq(1)
    expect(res.pay_tool_name).to eq('華泰銀行')
    expect(res.pay_tool_identity).to eq('123456******7890')
  end

  it 'refund' do
    json_string = '{ "status_code": "0000", "status_message": "查詢成功", "order_type": 2, "trade_info": { "mer_trade_no": "202101230000002", "px_trade_no": "PXO023892398239", "refund_mer_trade_no": "202101230000001", "refund_px_trade_no": "PXRO023892398239", "px_trade_time": "20210101093922", "amount": 300, "trade_amount": 277, "discount_amount": 23 } }'
    json_data = JSON.parse(json_string)
    res = PxPay::Response::Pos::Query.new(json_data, raw)
    expect(res.success?).to be true
    expect(res.message).to eq('查詢成功')
    expect(res.order_type).to eq(:refunded)
    expect(res.trade_number).to eq('202101230000002')
    expect(res.bank_transaction_id).to eq('PXO023892398239')
    expect(res.refund_trade_number).to eq('202101230000001')
    expect(res.trade_time).to eq(Time.parse('20210101093922'))
    expect(res.amount).to eq(300)
    expect(res.trade_amount).to eq(277)
    expect(res.discount_amount).to eq(23)
  end
end
