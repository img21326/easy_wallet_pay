require 'easy_card_pay/response/online/base'

module PxPay
  module Response
    module Online
      class Pay < Base
        attr_reader :payment_url, :qrcode

        def bank_transaction_id
          @transaction_id
        end
      end
    end
  end
end
