RSpec.describe EasyWalletPay::Request::Online::Refund do
  it 'basic' do
    config = EasyWalletPay::Config.new
    config.contract_id = 'contract_id'
    config.executor_id = 'executor_id'
    request = EasyWalletPay::Request::Online::Refund.new(
      bank_transaction_id: 'r_123',
      amount: 100
    )
    request.config = config
    hash = request.send(:to_hash)
    expect(hash[:contractNo]).to eq('contract_id')
    expect(hash[:orderNo]).to eq('r_123')
    expect(hash[:refundAmount]).to eq(100)
    expect(hash[:executorId]).to eq('executor_id')
    expect(hash[:rebateNotApplicableAmount]).to eq(0)
  end
end
