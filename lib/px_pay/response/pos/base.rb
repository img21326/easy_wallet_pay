# frozen_string_literal: true

require 'easy_card_pay/response/base'

module PxPay
  module Response
    module Pos
      class Base < ::PxPay::Response::Base
        def trade_time
          @trade_time ||= Time.parse(@px_trade_time)
        end
      end
    end
  end
end
