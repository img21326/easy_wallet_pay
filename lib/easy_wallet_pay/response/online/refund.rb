require 'easy_wallet_pay/response/online/base'

module EasyWalletPay
  module Response
    module Online
      class Refund < Base
        def order_id
          data&.dig('merchantOrderNo')
        end

        def bank_transaction_id
          data&.dig('orderNo')
        end

        def refund_bank_transaction_id
          data&.dig('refundPaymentNo')
        end

        def time
          data&.dig('refundDateTime')
        end
      end
    end
  end
end
