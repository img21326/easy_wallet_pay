require 'easy_wallet_pay/response/online/base'

module EasyWalletPay
  module Response
    module Online
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

        def payment_url 
          data&.dig('redirectPaymentUrl')
        end

        def time
          data&.dig('orderCreateDateTime')
        end
      end
    end
  end
end
