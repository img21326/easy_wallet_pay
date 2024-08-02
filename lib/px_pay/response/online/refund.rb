require 'easy_card_pay/response/online/base'

module PxPay
  module Response
    module Online
      class Refund < Base
        attr_reader :amount, :discount_amount, :trade_amount

        def bank_trade_id
          @px_trade_no
        end

        def bank_refund_trade_id
          @refund_px_trade_no
        end

        def order_id
          @mer_trade_no
        end

        def refund_order_id
          @refund_mer_trade_no
        end

        def trade_time
          @trade_time = Time.parse(@trade_time) if @trade_time.instance_of? String
        end
      end
    end
  end
end
