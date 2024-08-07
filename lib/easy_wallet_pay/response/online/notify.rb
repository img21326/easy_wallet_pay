require 'easy_wallet_pay/response/online/base'

module EasyWalletPay
  module Response
    module Online
      class Notify < Base
        def order_id
          data&.dig('merchantOrderNo')
        end

        def bank_transaction_id
          data&.dig('orderNo')
        end

        def paymentNo
          data&.dig('paymentNo')
        end

        def time
          data&.dig('orderCreateDateTime')
        end

        def amount
          data&.dig('orderAmount')
        end

        def rebateNotApplicableAmount
          data&.dig('rebateNotApplicableAmount')
        end

        def carrier
          data&.dig('einvoiceCarrier', 'einvoiceCarrierNo')
        end

        private

        def data
          json_data
        end
      end
    end
  end
end
