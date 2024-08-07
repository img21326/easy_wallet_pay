RSpec.describe EasyWalletPay::Response::Online::Query do
  it 'query' do
    json_string = '
      {
        "returnCode": "00000",
        "returnMsg": "成功",
        "data": {
          "sellerMemberUid": "1084308382",
          "merchantOrderNo": "108010100201",
          "orderNo": "10806130438932",
          "orderStatus": "PAYMENT_RECEIVED",
          "orderCreateDateTime": "20190612153250",
          "paymentMethod": "BALANCE",
          "currency": "TWD",
          "orderAmount": 110,
          "point": 10,
          "paymentAmount": 100,
          "eventCode": "EF3293",
          "rebateNotApplicableAmount": 0,
          "maskCreditCardNo": "",
          "cobrandedCode": "",
          "einvoiceCarrier": {
            "einvoiceCarrier Type": "3J0002",
            "einvoiceCarrierNo": "/QER3DEW",
            "dntFlag": "N",
            "dntNo": ""
          },
          "paymentDetail": [
            {
              "transactionAction": "PAYMENT",
              "paymentNo": "18431982394638",
              "paymentStatus": "COMPLETED",
              "paymentAmount": 110,
              "paymentDateTime": "20190612154315"
            }
          ]
        }
      }
    '
    res = EasyWalletPay::Response::Online::Query.new(json_string)

    expect(res.success?).to be true
    expect(res.message).to eq('成功')
    expect(res.order_id).to eq('108010100201')
    expect(res.is_paid?).to be true
    expect(res.bank_transaction_id).to eq('10806130438932')
    expect(res.amount).to eq(110)
    expect(res.time).to eq('20190612153250')
    expect(res.carrier).to eq('/QER3DEW')
  end

  it 'refund' do
    json_string = '
      {
        "returnCode": "00000",
        "returnMsg": "成功",
        "data": {
          "sellerMemberUid": "1084308382",
          "merchantOrderNo": "108010100201",
          "orderNo": "10806130438932",
          "orderStatus": "REFUND_COMPLETED",
          "orderCreateDateTime": "20190612153250",
          "paymentMethod": "BALANCE",
          "currency": "TWD",
          "orderAmount": 110,
          "point": 10,
          "paymentAmount": 100,
          "eventCode": "EF3293",
          "rebateNotApplicableAmount": 0,
          "maskCreditCardNo": "",
          "cobrandedCode": "",
          "einvoiceCarrier": {
            "einvoiceCarrier Type": "3J0002",
            "einvoiceCarrierNo": "/QER3DEW",
            "dntFlag": "N",
            "dntNo": ""
          },
          "paymentDetail": [
            {
              "transactionAction": "PAYMENT",
              "paymentNo": "18431982394638",
              "paymentStatus": "COMPLETED",
              "paymentAmount": 110,
              "paymentDateTime": "20190612154315"
            }
          ]
        }
      }
    '
    json_data = JSON.parse(json_string)
    res = EasyWalletPay::Response::Online::Query.new(json_string)
    expect(res.success?).to be true
    expect(res.message).to eq('成功')
    expect(res.order_id).to eq('108010100201')
    expect(res.is_paid?).to be false
    expect(res.is_refund?).to be true
    expect(res.bank_transaction_id).to eq('10806130438932')
    expect(res.amount).to eq(110)
    expect(res.time).to eq('20190612153250')
    expect(res.carrier).to eq('/QER3DEW')
  end
end
