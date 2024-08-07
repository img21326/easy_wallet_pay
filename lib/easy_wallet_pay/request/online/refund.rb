# frozen_string_literal: true

require 'easy_wallet_pay/request/online/base'
require 'easy_wallet_pay/response/online/refund'
require 'time'

module EasyWalletPay
  module Request
    module Online
      class Refund < Base
        def bank_transaction_id=(bank_transaction_id)
          @bank_transaction_id = bank_transaction_id.to_s
        end

        def amount=(amount)
          @amount = amount.to_i
        end

        private

        def to_hash
          super.merge(
            contractNo: config.contract_id,
            orderNo: @bank_transaction_id,
            refundAmount: @amount,
            executorId: config.executor_id,
            rebateNotApplicableAmount: 0,
          )
        end

        def response_klass
          EasyWalletPay::Response::Online::Refund
        end

        def request_action
          'Refund'
        end
      end
    end
  end
end
