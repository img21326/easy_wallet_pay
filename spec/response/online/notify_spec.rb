RSpec.describe PxPay::Response::Online::Notify do
  let(:raw) do
    class Raw
      def status
        200
      end
    end
    Raw.new
  end
  it 'paid' do
    json_string = '{ "mer_trade_no":"QW20210101000032", "transaction_id": "20210304000001", "px_trade_no":"PXO023892398239", "trade_time":"20210304170022", "amount": 300, "trade_amount": 277, "discount_amount": 23, "invo_carrier":"/NFVIAZP", "req_time": "20211227153030", "pay_tool_info": { "pay_tool": 1, "tool_name": "華泰銀行", "identity": "123456******7890" } }'
    json_data = JSON.parse(json_string)
    res = PxPay::Response::Online::Notify.new(json_data, raw)
    expect(res.order_id).to eq('QW20210101000032')
    expect(res.bank_transaction_id).to eq('20210304000001')
    expect(res.bank_trade_id).to eq('PXO023892398239')
    expect(res.trade_time).to eq(Time.parse('20210304170022'))
    expect(res.amount).to eq(300)
    expect(res.trade_amount).to eq(277)
    expect(res.discount_amount).to eq(23)
    expect(res.carrier).to eq('/NFVIAZP')
    expect(res.pay_tool).to eq(1)
    expect(res.pay_tool_name).to eq('華泰銀行')
    expect(res.card_number).to eq('123456******7890')
  end
end
