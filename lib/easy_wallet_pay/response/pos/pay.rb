require 'easy_wallet_pay/response/pos/base'

module EasyWalletPay
  module Response
    module Pos
      class Pay < Base
        def order_id
          data&.dig('merchantOrderNo')
        end

        def bank_transaction_id
          data&.dig('orderNo')
        end

        def payment_id
          data&.dig('paymentNo')
        end

        def amount
          data&.dig('orderAmount')
        end

        def time
          data&.dig('orderCreateDateTime')
        end

        def carrier
          data&.dig('einvoiceCarrier', 'einvoiceCarrierNo')
        end
      end
    end
  end
end
