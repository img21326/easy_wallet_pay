require 'easy_wallet_pay/response/pos/base'

module EasyWalletPay
  module Response
    module Pos
      class Query < Base
        def order_id
          data&.dig('merchantOrderNo')
        end

        def bank_transaction_id
          data&.dig('orderNo')
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

        def payment_id
          payment_records&.map{ |record| record['paymentNo'] }&.join(',') || ''
        end

        def payment_records
          data&.dig('paymentDetail')&.filter do |detail|
            detail['paymentStatus'] == 'PAYMENT_RECEIVED' ||
              detail['paymentStatus'] == 'COMPLETED'
          end
        end
      end
    end
  end
end
