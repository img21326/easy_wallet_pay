# frozen_string_literal: true

require 'easy_wallet_pay/response/base'

module EasyWalletPay
  module Response
    module Pos
      class Base < ::EasyWalletPay::Response::Base
        def trade_time
          @trade_time ||= Time.parse(@px_trade_time)
        end
      end
    end
  end
end
