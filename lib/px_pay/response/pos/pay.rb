require 'easy_card_pay/response/pos/base'

module PxPay
  module Response
    module Pos
      class Pay < Base
        attr_reader :amount, :trade_amount, :discount_amount

        def bank_transaction_id
          @px_trade_no
        end

        def trade_number
          @mer_trade_no
        end

        def carrier
          @invo_carrier
        end

        def pay_tool
          @pay_tool_info.dig('pay_tool')
        end

        def pay_tool_name
          @pay_tool_info.dig('tool_name')
        end

        def pay_tool_identity
          @pay_tool_info.dig('identity')
        end
      end
    end
  end
end
