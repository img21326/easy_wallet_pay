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
                                                          confirm_url: 'http://localhost:3333/stores/e6aada6c/easy_wallet?order_id=PH_0906278263_1712631570%23WEB%23292%231724117094.347604&redirect_to=%2Fstores%2Fe6aada6c',
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
      expect(res.payment_url).not_to be_nil
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

  describe '#pos' do
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
    bank_transaction_id = nil

    it 'pay' do
      ## PAY TOKEN NEED BE REFRESH FROM
      ## https://epgwt.easycard.com.tw/uupay-api-merchant-test/standard/v1/trade/test/choosePaymentMethod
      request = EasyWalletPay::Request::Pos::Pay.new({
                                                       order_id: order_id,
                                                       amount: 100,
                                                       pay_token: '99701134112706002109'
                                                     })
      request.config = config
      res = request.request
      p request.log_data
      p res.raw
      expect(res.success?).to be(true)
      expect(res.order_id).to eq(order_id)
      expect(res.amount).to eq(100)
      expect(res.bank_transaction_id).not_to be_nil
      bank_transaction_id = res.bank_transaction_id
      expect(res.time).not_to be_nil
    end

    it 'query' do
      request = EasyWalletPay::Request::Pos::Query.new({
                                                         bank_transaction_id: bank_transaction_id
                                                       })
      request.config = config
      res = request.request
      p request.log_data
      p res.raw
      expect(res.success?).to be(true)
      expect(res.order_id).to eq(order_id)
      expect(res.is_paid?).to be(true)
      expect(res.is_refund?).to be(false)
      expect(res.time).not_to be_nil
      expect(res.payment_id).not_to be_nil
      p res.payment_id
    end

    it 'refund' do
      request = EasyWalletPay::Request::Pos::Refund.new({
                                                          bank_transaction_id: bank_transaction_id,
                                                          amount: 100
                                                        })
      request.config = config
      res = request.request
      p request.log_data
      p res.raw
      expect(res.success?).to be(true)
      expect(res.order_id).to eq(order_id)
      expect(res.time).not_to be_nil
    end

    it 'query refund' do
      request = EasyWalletPay::Request::Pos::Query.new({
                                                         bank_transaction_id: bank_transaction_id
                                                       })
      request.config = config
      res = request.request
      p request.log_data
      p res.raw
      expect(res.success?).to be(true)
      expect(res.order_id).to eq(order_id)
      expect(res.is_paid?).to be(false)
      expect(res.is_refund?).to be(true)
      expect(res.time).not_to be_nil
    end
  end
end
