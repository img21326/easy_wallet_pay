RSpec.describe EasyWalletPay::Request::Online::Query do
  it 'basic' do
    request = EasyWalletPay::Request::Online::Query.new(
      order_id: '123'
    )
    config = EasyWalletPay::Config.new
    config.store_id = 'store_id'
    config.contract_id = 'contract_id'
    request.config = config

    hash = request.send(:to_hash)
    expect(hash[:merchantOrderNo]).to eq('123')
    expect(hash[:contractNo]).to eq('contract_id')
  end
end
