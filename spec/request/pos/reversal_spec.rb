RSpec.describe PxPay::Request::Pos::Reversal do
  it 'basic' do
    time = Time.now
    request = PxPay::Request::Pos::Reversal.new(
      store_id: '123',
      store_name: 'store_name',
      pos_id: '456',
      trade_number: 'merchant_trade_number_id',
      trade_time: time,
      pay_token: 'pay_token',
      amount: 100
    )
    req_time = request.send(:request_time)
    hash = request.send(:to_hash)
    expect(hash[:store_id]).to eq('123')
    expect(hash[:store_name]).to eq('store_name')
    expect(hash[:pos_id]).to eq('456')
    expect(hash[:pos_trade_time]).to eq(time.strftime('%Y%m%d%H%M%S'))
    expect(hash[:mer_trade_no]).to eq('merchant_trade_number_id')
    expect(hash[:pay_token]).to eq('pay_token')
    expect(hash[:amount]).to eq(100)
    expect(request.send(:hash_string)).to eq("123456#{time.strftime('%Y%m%d%H%M%S')}merchant_trade_number_idpay_token100#{req_time}")
  end
end
