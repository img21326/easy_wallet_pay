# frozen_string_literal: true

require 'easy_wallet_pay/request/base'

module EasyWalletPay
  module Request
    module Online
      class Base < EasyWalletPay::Request::Base
        private

        def api_host
          "#{config&.api_host}/px-ec"
        end
      end
    end
  end
end
