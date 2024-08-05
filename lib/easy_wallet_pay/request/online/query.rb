# frozen_string_literal: true

require 'easy_wallet_pay/request/online/base'
require 'easy_wallet_pay/response/online/query'

module EasyWalletPay
  module Request
    module Online
      class Query < Base
        def order_id=(order_id)
          @order_id = order_id.to_s
        end

        def trade_no_type=(trade_no_type)
          raise ArgumentError, 'trade_no_type must be Merchant or PX' unless %w[Merchant PX].include?(trade_no_type)

          @trade_no_type = trade_no_type
        end

        def trade_no_type
          @trade_no_type || 'Merchant'
        end

        private

        def to_hash
          nil
        end

        def response_klass
          EasyWalletPay::Response::Online::Query
        end

        def request_action
          'Order'
        end

        def request_type
          :get
        end

        def hash_string
          [trade_no_type, @order_id, request_time].join
        end

        def end_point
          "#{super}/#{trade_no_type}/#{@order_id}/#{request_time}"
        end
      end
    end
  end
end
