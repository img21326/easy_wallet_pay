# frozen_string_literal: true

require 'easy_wallet_pay/request/online/base'
require 'easy_wallet_pay/response/online/query'

module EasyWalletPay
  module Request
    module Online
      class Query < Base
        def order_id=(order_id)
          @order_id = order_id.to_s
        end

        private

        def to_hash
          super.merge({
                        merchantOrderNo: @order_id,
                        contractNo: config.contract_id
                      })
        end

        def response_klass
          EasyWalletPay::Response::Online::Query
        end

        def request_action
          'queryMerchantOrder'
        end
      end
    end
  end
end
