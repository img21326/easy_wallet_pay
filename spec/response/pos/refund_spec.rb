RSpec.describe EasyWalletPay::Response::Pos::Refund do
  it 'basic' do
    json_string = '
      {
        "returnCode": "00000",
        "returnMsg": "成功",
        "data": {
          "sellerMemberUid": "1084308382",
          "merchantOrderNo": "108010100201",
          "orderNo": "10806130438932",
          "orderStatus": "REFUND_COMPLETED",
          "refundPaymentNo": "18431982394638",
          "refundPaymentStatus": "COMPLETED",
          "refundDateTime": "20190612154315"
        }
      }
    '
    res = EasyWalletPay::Response::Pos::Refund.new(json_string)
    expect(res.success?).to be true
    expect(res.message).to eq('成功')
    expect(res.order_id).to eq('108010100201')
    expect(res.is_paid?).to be false
    expect(res.is_refund?).to be true
    expect(res.bank_transaction_id).to eq('10806130438932')
    expect(res.refund_bank_transaction_id).to eq('18431982394638')
    expect(res.time).to eq('20190612154315')
  end
end
