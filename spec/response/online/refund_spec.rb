RSpec.describe PxPay::Response::Online::Refund do
  let(:raw) do
    class Raw
      def status
        200
      end
    end
    Raw.new
  end

  it 'basic' do
    json_string = '{ "status_code": "0000", "status_message": "交易成功", "mer_trade_no":"202101230000002", "px_trade_no": "PXO023892398239", "refund_mer_trade_no":"202101230000001", "refund_px_trade_no": "PXRO023892398239", "trade_time":"20210101093922", "amount": 300, "trade_amount": 277, "discount_amount": 23 }'
    json_data = JSON.parse(json_string)
    res = PxPay::Response::Online::Refund.new(json_data, raw)
    expect(res.success?).to be true
    expect(res.message).to eq('交易成功')
    expect(res.order_id).to eq('202101230000002')
    expect(res.bank_trade_id).to eq('PXO023892398239')
    expect(res.refund_order_id).to eq('202101230000001')
    expect(res.bank_refund_trade_id).to eq('PXRO023892398239')
    expect(res.trade_time).to eq(Time.parse('20210101093922'))
    expect(res.amount).to eq(300)
    expect(res.trade_amount).to eq(277)
    expect(res.discount_amount).to eq(23)
  end
end
