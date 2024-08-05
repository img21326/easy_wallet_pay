require 'easy_wallet_pay/response/online/base'

module EasyWalletPay
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
