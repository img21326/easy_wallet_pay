RSpec.describe EasyWalletPay::Response::Online::Pay do
  it 'basic' do
    json_string = '{
      "returnCode": "00000",
      "returnMsg": "成功",
      "data": {
        "sellerMemberUid": "1084308382",
        "merchantOrderNo": "108010100201",
        "orderNo": "10806130438932",
        "paymentNo": "18431982394638",
        "orderStatus": "PREORDER",
        "orderCreateDateTime": "20190612153250",
        "paymentMethod": null,
        "currency": "TWD",
        "orderAmount": 110,
        "point": null,
        "paymentAmount": null,
        "eventCode": "EVNEIE",
        "rebateNotApplicableAmount": 0,
        "maskCreditCardNo": null,
        "cobrandedCode": null,
        "redirectPaymentUrl": "http://uupay.com.tw/LAKDJF0943983KDA0D928"
      }
    }'
    res = EasyWalletPay::Response::Online::Pay.new(json_string)
    expect(res.success?).to be true
    expect(res.message).to eq('成功')
    expect(res.bank_transaction_id).to eq('10806130438932')
    expect(res.payment_id).to eq('18431982394638')
    expect(res.amount).to eq(110)
    expect(res.redirect_url).to eq('http://uupay.com.tw/LAKDJF0943983KDA0D928')
    expect(res.time).to eq('20190612153250')
  end
end
