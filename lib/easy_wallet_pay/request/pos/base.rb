# frozen_string_literal: true

require 'easy_wallet_pay/request/base'

module EasyWalletPay
  module Request
    module Pos
      class Base < EasyWalletPay::Request::Base
        private

        def request_type
          :post
        end
      end
    end
  end
end
