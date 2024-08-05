require 'easy_wallet_pay/response/pos/base'

module EasyWalletPay
  module Response
    module Pos
      class Refund < Base
        attr_reader :amount, :discount_amount, :trade_amount

        def carrier
          @invo_carrier
        end

        def bank_transaction_id
          @px_trade_no
        end

        def trade_number
          @mer_trade_no
        end
      end
    end
  end
end
