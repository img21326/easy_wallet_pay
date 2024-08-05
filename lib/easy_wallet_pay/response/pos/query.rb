require 'easy_wallet_pay/response/online/base'

module EasyWalletPay
  module Response
    module Pos
      class Query < Base
        attr_reader :trade_info

        def trade_number
          @trade_info.dig('mer_trade_no')
        end

        def refund_trade_number
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

        def bank_transaction_id
          @trade_info.dig('px_trade_no')
        end

        def trade_time
          return if @trade_info.dig('px_trade_time').instance_of?(Time)

          @trade_time = Time.parse(@trade_info.dig('px_trade_time'))
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

        def pay_tool
          @trade_info.dig('pay_tool_info', 'pay_tool')
        end

        def pay_tool_name
          @trade_info.dig('pay_tool_info', 'tool_name')
        end

        def pay_tool_identity
          @trade_info.dig('pay_tool_info', 'identity')
        end
      end
    end
  end
end
