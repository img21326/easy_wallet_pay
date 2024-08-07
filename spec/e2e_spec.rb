require 'securerandom'
RSpec.describe EasyWalletPay do
  describe '#ec' do
    let!(:config) do
      config = EasyWalletPay::Config.new
      config.account = ENV['EASY_WALLET_PAY_ACCOUNT']
      config.store_id = ENV['EASY_WALLET_PAY_STORE_ID']
      config.store_name = ENV['EASY_WALLET_PAY_STORE_NAME']
      config.secret_key = ENV['EASY_WALLET_PAY_SECRET_KEY']
      config.contract_id = ENV['EASY_WALLET_PAY_CONTRACT_ID']
      config.executor_id = ENV['EASY_WALLET_PAY_EXECUTOR_ID']
      config
    end

    order_id = SecureRandom.hex(10)

    it 'pay' do
      request = EasyWalletPay::Request::Online::Pay.new({
                                                          order_id: order_id,
                                                          amount: 100,
                                                          return_url: 'http://example.com/return_url',
                                                          notify_url: 'http://example.com/notify_url'
                                                        })
      request.config = config
      res = request.request
      p request.log_data
      p res.raw
      expect(res.success?).to be(true)
      expect(res.order_id).to eq(order_id)
      expect(res.amount).to eq(100)
      expect(res.bank_transaction_id).not_to be_nil
      expect(res.redirect_url).not_to be_nil
      expect(res.time).not_to be_nil
    end

    it 'query' do
      request = EasyWalletPay::Request::Online::Query.new({
                                                            order_id: order_id
                                                          })
      request.config = config
      res = request.request
      p request.log_data
      p res.raw
      expect(res.success?).to be(true)
      expect(res.order_id).to eq(order_id)
      expect(res.amount).to eq(100)
      expect(res.is_paid?).to be(false)
      expect(res.is_refund?).to be(false)
      expect(res.time).not_to be_nil
    end
  end

  # it 'pos_pay' do
  #   request = EasyWalletPay::Request::Pos::Pay.new({
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
  #   request = EasyWalletPay::Request::Pos::Query.new({
  #                                              trade_number: '1#1'
  #                                            })

  #   request.config = pos_config
  #   res = request.request
  #   p request.send :end_point
  #   expect(res.success?).to be(true)
  # end
end
