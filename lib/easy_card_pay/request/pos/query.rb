# frozen_string_literal: true

require 'easy_card_pay/request/pos/base'
require 'easy_card_pay/response/pos/query'

module EasyCardPay
  module Request
    module Pos
      class Query < Base
        attr_writer :trade_no_type

        def trade_number=(trade_number)
          @trade_number = trade_number.to_s
        end

        def trade_no_type=(trade_no_type)
          @trade_no_type = {
            Merchant: 1,
            Gateway: 2,
            Px: 3
          }[trade_no_type]
          raise ArgumentError, 'trade_no_type must be Merchant or Px' unless @trade_no_type
        end

        def trade_no_type
          @trade_no_type || 1
        end

        private

        def response_klass
          EasyCardPay::Response::Pos::Query
        end

        def to_hash
          nil
        end

        def request_action
          'OrderStatus'
        end

        def request_type
          :get
        end

        def hash_string
          [trade_no_type, @trade_number, @request_time].join
        end

        def end_point
          "#{super}/#{trade_no_type}/#{@trade_number}/#{request_time}"
        end
      end
    end
  end
end
