require 'easy_wallet_pay/response/online/base'

module EasyWalletPay
  module Response
    module Online
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

        def refund_bank_transaction_id
          refund_record&.last&.dig('paymentNo')
        end

        def refund_time
          refund_record&.last&.dig('paymentDateTime')
        end

        def refund_record
          data&.dig('paymentDetail')&.filter do |detail|
            detail['paymentStatus'] == 'REFUND_COMPLETED'
          end
        end
      end
    end
  end
end
