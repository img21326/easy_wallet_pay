RSpec.describe PxPay::Response::Online::Pay do
  let(:raw) do
    class Raw
      def status
        200
      end
    end
    Raw.new
  end
  it 'basic' do
    json_string = '{"status_code": "0000","status_message": "交易成功","transaction_id": "20210304000001","payment_url": "https://xxx.xxx.xxx/pxplus_ec/page_redirect?data=aHR0cHM6Ly","qrcode": "https://xxx.xxx.xxx/ec/qrcode?data=aHR0cHM6Ly"}'
    json_data = JSON.parse(json_string)
    res = PxPay::Response::Online::Pay.new(json_data, raw)
    expect(res.success?).to be true
    expect(res.message).to eq('交易成功')
    expect(res.bank_transaction_id).to eq('20210304000001')
    expect(res.payment_url).to eq('https://xxx.xxx.xxx/pxplus_ec/page_redirect?data=aHR0cHM6Ly')
    expect(res.qrcode).to eq('https://xxx.xxx.xxx/ec/qrcode?data=aHR0cHM6Ly')
  end
end
