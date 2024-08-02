RSpec.describe PxPay::Request::Online::Refund do
  it 'basic' do
    request = PxPay::Request::Online::Refund.new(
      order_id: '123',
      refund_order_id: 'r_123',
      bank_trade_id: '456',
      amount: 100,
      trade_time: '20170101000000'
    )
    req_time = request.send(:request_time)
    hash = request.send(:to_hash)
    expect(hash[:mer_trade_no]).to eq('123')
    expect(hash[:amount]).to eq(100)
    expect(hash[:px_trade_no]).to eq('456')
    expect(hash[:refund_mer_trade_no]).to eq('r_123')
    expect(hash[:trade_time]).to eq('20170101000000')
    expect(request.send(:hash_string)).to eq("12345620170101000000r_123100#{req_time}")
  end
end
