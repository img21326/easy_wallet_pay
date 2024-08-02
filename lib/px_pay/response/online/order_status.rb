require 'easy_card_pay/response/online/base'

module PxPay
  module Response
    module Online
      class OrderStatus < Base
        def bank_transaction_id
          @transaction_id
        end

        def request_time
          @req_time
        end
      end
    end
  end
end
