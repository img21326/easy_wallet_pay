require 'easy_card_pay/response/online/base'

module PxPay
  module Response
    module Online
      class Query < Base
        def order_id
          @trade_info.dig('mer_trade_no')
        end

        def refund_order_id
          @trade_info.dig('refund_mer_trade_no')
        end

        def order_type
          case @order_type
          when 0
            return :not_found
          when 1
            return :paid
          when 2
            return :refunded
          end
          nil
        end

        def bank_trade_id
          @trade_info.dig('px_trade_no')
        end

        def bank_transaction_id
          @trade_info.dig('transaction_id')
        end

        def trade_time
          @trade_time ||= Time.parse(@trade_info.dig('trade_time'))
        end

        def amount
          @trade_info.dig('amount')
        end

        def trade_amount
          @trade_info.dig('trade_amount')
        end

        def discount_amount
          @trade_info.dig('discount_amount')
        end

        def carrier
          @trade_info.dig('invo_carrier')
        end

        def pay_status
          status = @trade_info.dig('pay_status')
          case status
          when 0
            return :unpaid
          when 1
            return :paid
          end
          nil
        end

        def pay_tool
          @trade_info.dig('pay_tool_info', 'pay_tool')
        end

        def pay_tool_name
          @trade_info.dig('pay_tool_info', 'tool_name')
        end

        def card_number
          @trade_info.dig('pay_tool_info', 'identity')
        end

        def bank_refund_trade_id
          @trade_info.dig('refund_px_trade_no')
        end
      end
    end
  end
end
