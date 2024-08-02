require 'easy_card_pay/response/online/base'

module PxPay
  module Response
    module Online
      class Notify < Base
        attr_reader :amount, :trade_amount, :discount_amount

        def order_id
          @mer_trade_no
        end

        def bank_trade_id
          @px_trade_no
        end

        def bank_transaction_id
          @transaction_id
        end

        def carrier
          @invo_carrier
        end

        def trade_time
          @trade_time = Time.parse(@trade_time) if @trade_time.instance_of? String
        end

        def pay_tool
          @pay_tool_info.dig('pay_tool')
        end

        def pay_tool_name
          @pay_tool_info.dig('tool_name')
        end

        def card_number
          @pay_tool_info.dig('identity')
        end

        def request_time
          @req_time
        end
      end
    end
  end
end
