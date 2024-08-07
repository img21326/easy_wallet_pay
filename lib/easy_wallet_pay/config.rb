module EasyWalletPay
  class Config
    PRODUCTION_HOST = 'https://epgw.easycard.com.tw/uupay-api-merchant/standard/v1/trade'.freeze
    SANDBOX_HOST = 'https://epgwt.easycard.com.tw/uupay-api-merchant/standard/v1/trade'.freeze

    attr_accessor :mode, :secret_key, :store_name, :account, :contract_id, :executor_id
    attr_reader :store_id

    def initialize
      @mode = :sandbox
      @account = nil
      @store_id = nil
      @store_name = nil
      @secret_key = nil
      @contract_id = nil
      @executor_id = nil
    end

    def store_id=(store_id)
      @store_id = store_id.to_s
    end

    def production?
      @mode != :sandbox
    end

    def api_host
      return PRODUCTION_HOST if production?

      SANDBOX_HOST
    end
  end
end
