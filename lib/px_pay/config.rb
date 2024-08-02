module PxPay
  class Config
    PRODUCTION_HOST = 'https://ec.pxpayplus.com'.freeze
    SANDBOX_HOST = 'https://uat.pxpayplus.com'.freeze

    attr_accessor :mode, :secret_key, :store_name, :account
    attr_reader :store_id

    def initialize
      @mode = :sandbox
      @account = nil
      @store_id = nil
      @store_name = nil
      @secret_key = nil
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
