# frozen_string_literal: true

require 'easy_card_pay/request/base'

module EasyCardPay
  module Request
    module Online
      class Base < EasyCardPay::Request::Base
        private

        def api_host
          "#{config&.api_host}/px-ec"
        end
      end
    end
  end
end
