RSpec.describe EasyWalletPay::Response::Online::Pay do
  it 'basic' do
    json_string = '
    {
      "returnCode": "00000",
      "returnMsg": "成功",
      "data": {
        "sellerMemberUid": "1084308382",
        "merchantOrderNo": "108010100202",
        "orderNo": "10806130321433",
        "paymentNo": "14334434434417",
        "orderStatus": "PAYMENT_RECEIVED",
        "orderCreateDateTime": "20190612154330",
        "paymentMethod": "BALANCE",
        "currency": "TWD",
        "orderAmount": 110,
        "point": 10,
        "paymentAmount": 100,
        "eventCode": "EF3293",
        "rebateNotApplicableAmount": 0,
        "merchantMemberUID": "ABCD12345",
        "einvoiceCarrier": {
          "einvoiceCarrierType": "3J0002",
          "einvoiceCarrierNo": "/QER3DEW",
          "dntFlag": "N",
          "dntNo": ""
        }
      }
    }
    '
    res = EasyWalletPay::Response::Online::Pay.new(json_string)
    p res.send :data
    expect(res.success?).to be true
    expect(res.message).to eq('成功')
    expect(res.bank_transaction_id).to eq('10806130321433')
    expect(res.payment_id).to eq('14334434434417')
    expect(res.amount).to eq(110)
    expect(res.time).to eq('20190612154330')
  end
end
