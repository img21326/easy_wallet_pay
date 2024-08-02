RSpec.describe PxPay::Request::Pos::Pay do
  it 'basic' do
    request = PxPay::Request::Pos::Pay.new(
      store_id: '123',
      store_name: 'store_name',
      pos_id: '456',
      trade_time: '20170101000000',
      trade_number: '789',
      pay_token: 'pay_token',
      amount: 100
    )

    hash = request.send(:to_hash)
    time = request.send(:request_time)
    expect(hash[:store_id]).to eq('123')
    expect(hash[:store_name]).to eq('store_name')
    expect(hash[:pos_id]).to eq('456')
    expect(hash[:pos_trade_time]).to eq('20170101000000')
    expect(hash[:mer_trade_no]).to eq('789')
    expect(hash[:pay_token]).to eq('pay_token')
    expect(hash[:amount]).to eq(100)
    expect(request.send(:hash_string)).to eq("12345620170101000000789pay_token100#{time}")
  end
end
