RSpec.describe PxPay::Request::Pos::Refund do
  it 'basic' do
    time = Time.now
    request = PxPay::Request::Pos::Refund.new(
      store_id: '123',
      store_name: 'store_name',
      pos_id: '456',
      trade_number: 'merchant_trade_number_id',
      refund_trade_number: 'refund_merchant_trade_number_id',
      bank_transaction_id: 'px_trade_no',
      trade_time: time,
      amount: 100
    )
    req_time = request.send(:request_time)
    hash = request.send(:to_hash)
    expect(hash[:store_id]).to eq('123')
    expect(hash[:store_name]).to eq('store_name')
    expect(hash[:pos_id]).to eq('456')
    expect(hash[:pos_trade_time]).to eq(time.strftime('%Y%m%d%H%M%S'))
    expect(hash[:ori_mer_trade_no]).to eq('merchant_trade_number_id')
    expect(hash[:ori_px_trade_no]).to eq('px_trade_no')
    expect(hash[:mer_trade_no]).to eq('refund_merchant_trade_number_id')
    expect(hash[:amount]).to eq(100)
    expect(request.send(:hash_string)).to eq("123456#{time.strftime('%Y%m%d%H%M%S')}merchant_trade_number_idrefund_merchant_trade_number_id100#{req_time}")
  end
end
