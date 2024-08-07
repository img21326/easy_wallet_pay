# frozen_string_literal: true

require 'easy_wallet_pay/request/pos/base'
require 'easy_wallet_pay/response/pos/pay'

module EasyWalletPay
  module Request
    module Pos
      class Refund < Base
        def order_id=(order_id)
          @order_id = order_id.to_s
        end

        def bank_transaction_id=(bank_transaction_id)
          @bank_transaction_id = bank_transaction_id.to_s
        end

        def pos_id=(pos_id)
          @pos_id = pos_id.to_s
        end

        def amount=(amount)
          @amount = amount.to_i
        end

        private

        def to_hash
          hash = super.merge(
            merchantOrderNo: @order_id,
            contractNo: config.contract_id,
            orderNo: @bank_transaction_id,
            refundAmount: @amount,
            rebateNotApplicableAmount: 0
          )
          hash[:posSN] = @pos_id if @pos_id
          hash
        end

        def response_klass
          EasyWalletPay::Response::Pos::Refund
        end

        def request_action
          'refundPOSOrder'
        end
      end
    end
  end
end
