RSpec.describe PxPay::Request::Online::Pay do
  it 'basic' do
    request = PxPay::Request::Online::Pay.new(
      order_id: '123',
      amount: 100,
      device_type: :pc,
      web_confirm_url: 'http://example.com/confirm',
      web_cancel_url: 'http://example.com/cancel',
      status_url: 'http://example.com/status_url',
      notify_url: 'http://example.com/notify_url'
    )
    hash = request.send(:to_hash)
    time = request.send(:request_time)
    expect(hash[:mer_trade_no]).to eq('123')
    expect(hash[:amount]).to eq(100)
    expect(hash[:device_type]).to eq(1)
    expect(hash[:web_confirm_url]).to eq('http://example.com/confirm')
    expect(hash[:web_cancel_url]).to eq('http://example.com/cancel')
    expect(hash[:order_status_url]).to eq('http://example.com/status_url')
    expect(hash[:payment_notify_url]).to eq('http://example.com/notify_url')
    expect(request.send(:hash_string)).to eq("1231001#{time}")
  end
end
