require 'securerandom'
RSpec.describe EasyCardPay do
  let!(:ec_config) do
    config = EasyCardPay::Config.new
    config.account = ENV['STORE_ID']
    config.store_name = 'S0006787'
    config.secret_key = ENV['SECRET_KEY']
    config
  end

  let!(:pos_config) do
    config = EasyCardPay::Config.new
    config.account = ENV['POS_STORE_ID']
    config.store_name = 'S0006786'
    config.secret_key = ENV['POS_SECRET_KEY']
    config
  end
  let(:ec_order_id) { 'test_1231' }
  let(:pos_order_id) { 222_223_333 }

  # it 'online_pay' do
  #   request = EasyCardPay::Request::Online::Pay.new({
  #                                               order_id: ec_order_id,
  #                                               amount: 1,
  #                                               device_type: :pc,
  #                                               web_confirm_url: 'http://example.com/confirm',
  #                                               web_cancel_url: 'http://example.com/cancel',
  #                                               notify_url: 'https://istore.weibyapps.com:8123/easy_card_pay/result',
  #                                               status_url: 'https://istore.weibyapps.com:8123/easy_card_pay/orders'
  #                                             })
  #   request.config = ec_config
  #   res = request.request
  #   expect(res.success?).to be(true)
  # end

  # it 'pos_pay' do
  #   request = EasyCardPay::Request::Pos::Pay.new({
  #                                            store_id: 1,
  #                                            store_name: 'weiby_test',
  #                                            pos_id: 1,
  #                                            trade_time: Time.now,
  #                                            merchant_trade_number: pos_order_id,
  #                                            amount: 100,
  #                                            pay_token: 'P2A27194D27P53GR1I'
  #                                          })

  #   request.config = pos_config
  #   res = request.request
  #   expect(res.success?).to be(true)
  # end

  # it 'pos_query' do
  #   request = EasyCardPay::Request::Pos::Query.new({
  #                                              trade_number: '1#1'
  #                                            })

  #   request.config = pos_config
  #   res = request.request
  #   p request.send :end_point
  #   expect(res.success?).to be(true)
  # end
end
