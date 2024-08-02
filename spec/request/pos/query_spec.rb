RSpec.describe EasyCardPay::Request::Pos::Query do
  it 'basic' do
    time = Time.now
    request = EasyCardPay::Request::Pos::Query.new(
      trade_no_type: :Merchant,
      trade_number: '123'
    )
    req_time = request.send(:request_time)
    hash = request.send(:to_hash)
    expect(hash).to eq(nil)
    expect(request.send(:hash_string)).to eq("1123#{req_time}")
    expect(request.send(:end_point)).to eq("https://uat.EasyCardPayplus.com/px-pos/OrderStatus/1/123/#{req_time}")
  end
end
