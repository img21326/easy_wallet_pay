# frozen_string_literal: true

require 'easy_wallet_pay/request/online/base'
require 'easy_wallet_pay/response/online/query'

module EasyWalletPay
  module Request
    module Pos
      class Query < Base
        def order_id=(order_id)
          @order_id = order_id.to_s
        end

        def bank_transaction_id=(bank_transaction_id)
          @bank_transaction_id = bank_transaction_id.to_s
        end

        private

        def to_hash
          hash = super.merge(
            contractNo: config.contract_id
          )
          if @bank_transaction_id.present?
            hash[:orderNo] = @bank_transaction_id
          else
            hash[:merchantOrderNo] = @order_id
          end
          hash
        end

        def response_klass
          EasyWalletPay::Response::Online::Query
        end

        def request_action
          return 'queryOrder' if @bank_transaction_id.present?

          'queryMerchantOrder'
        end
      end
    end
  end
end
