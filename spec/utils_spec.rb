RSpec.describe EasyWalletPay do
  it 'basic' do
    secret_key = '6b87baeb124bb5ed5d531ddc5cdd3727532ebf45c2e81b0b19270e5afc13c7d2'
    data = {
      a: '1',
      b: '2'
    }

    should_be = '5b163d6f650c23586df7da138fce8c3695b49548879482b4f7d4faa7f8261e57'
    p EasyWalletPay::Utils.sign(data, secret_key)
    expect(EasyWalletPay::Utils.sign(data, secret_key)).to eq(should_be)
  end
end
