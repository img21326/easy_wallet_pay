RSpec.describe EasyWalletPay::Request::Pos::Refund do
  it 'basic' do
    request = EasyWalletPay::Request::Pos::Refund.new(
      order_id: '123',
      bank_transaction_id: 'r_123',
      amount: 100
    )
    config = EasyWalletPay::Config.new
    config.store_id = 'store_id'
    config.contract_id = 'contract_id'
    request.config = config

    hash = request.send(:to_hash)
    expect(hash[:merchantOrderNo]).to eq('123')
    expect(hash[:orderNo]).to eq('r_123')
    expect(hash[:refundAmount]).to eq(100)
    expect(hash[:rebateNotApplicableAmount]).to eq(0)
    expect(hash[:contractNo]).to eq('contract_id')
  end
end
