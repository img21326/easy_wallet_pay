RSpec.describe PxPay::Response::Pos::Reversal do
  let(:raw) do
    class Raw
      def status
        200
      end
    end
    Raw.new
  end

  it 'basic' do
    json_string = '{"status_code":"0000","status_message":"交易成功","px_trade_time": "20210710143259" }'
    json_data = JSON.parse(json_string)
    res = PxPay::Response::Pos::Reversal.new(json_data, raw)
    expect(res.success?).to be true
    expect(res.message).to eq('交易成功')
    expect(res.trade_time).to eq(Time.parse('20210710143259'))
  end
end
