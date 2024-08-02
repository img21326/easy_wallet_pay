# frozen_string_literal: true

require 'easy_card_pay/request/base'

module PxPay
  module Request
    module Pos
      class Base < PxPay::Request::Base
        private

        def api_host
          "#{config&.api_host}/px-pos"
        end
      end
    end
  end
end
