RSpec.describe EasyWalletPay::Request::Pos::Pay do
  it 'basic' do
    config = EasyWalletPay::Config.new
    config.store_id = 'store_id'
    config.contract_id = 'contract_id'
    request = EasyWalletPay::Request::Pos::Pay.new(
      order_id: '123',
      pay_token: 'pay_token',
      amount: 100,
      pos_id: '456'
    )
    request.config = config

    hash = request.send(:to_hash)[:order]
    expect(hash[:contractNo]).to eq('contract_id')
    expect(hash[:currency]).to eq('TWD')
    expect(hash[:merchantOrderNo]).to eq('123')
    expect(hash[:tradeType]).to eq('IMMEDIATE')
    expect(hash[:orderAmount]).to eq(100)
    expect(hash[:rebateNotApplicableAmount]).to eq(0)
    expect(hash[:paymentBarCode]).to eq('pay_token')
    expect(hash[:orderItems]).to eq([])
    expect(hash[:rewardPointsList]).to eq([])
  end
end
