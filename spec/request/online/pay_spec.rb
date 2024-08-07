RSpec.describe EasyWalletPay::Request::Online::Pay do
  it 'basic' do
    config = EasyWalletPay::Config.new
    config.store_id = 'store_id'
    config.contract_id = 'contract_id'
    request = EasyWalletPay::Request::Online::Pay.new(
      order_id: '123',
      amount: 100,
      return_url: 'http://example.com/return_url',
      notify_url: 'http://example.com/notify_url'
    )
    request.config = config
    hash = request.send(:to_hash)
    time = request.send(:request_time)
    request_action = request.send(:request_action)
    expect(hash[:callBackUrl]).to eq('http://example.com/return_url')
    expect(hash[:notifyUrl]).to eq('http://example.com/notify_url')
    expect(hash[:merchantStoreId]).to eq('store_id')

    order_data = hash[:order]
    expect(order_data[:contractNo]).to eq('contract_id')
    expect(order_data[:currency]).to eq('TWD')
    expect(order_data[:merchantOrderNo]).to eq('123')
    expect(order_data[:tradeType]).to eq('IMMEDIATE')
    expect(order_data[:orderAmount]).to eq(100)
    expect(order_data[:rebateNotApplicableAmount]).to eq(0)
    expect(order_data[:orderItems]).to eq([])

    expect(request_action).to eq('createECOrder')
  end
end
