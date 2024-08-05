RSpec.describe EasyWalletPay::Request::Online::Query do
  it 'basic' do
    time = Time.now
    request = EasyWalletPay::Request::Online::Query.new(
      order_id: '123'
    )
    req_time = request.send(:request_time)
    hash = request.send(:to_hash)
    expect(hash).to eq(nil)
    expect(request.send(:hash_string)).to eq("Merchant123#{req_time}")
    expect(request.send(:end_point)).to eq("https://uat.EasyWalletPayplus.com/px-ec/Order/Merchant/123/#{req_time}")
  end
end
