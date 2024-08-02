RSpec.describe PxPay::Request::Pos::MemberInfo do
  it 'basic' do
    request = PxPay::Request::Pos::MemberInfo.new(
      pay_token: 'abc'
    )
    hash = request.send(:to_hash)
    time = request.send(:request_time)
    expect(hash[:pay_token]).to eq('abc')
    expect(request.send(:hash_string)).to eq("abc#{time}")
  end
end
