# frozen_string_literal: true

require 'easy_wallet_pay/request/online/base'
require 'easy_wallet_pay/response/online/pay'

module EasyWalletPay
  module Request
    module Online
      class Pay < Base
        attr_writer :return_url, :notify_url, :order_desc

        def order_id=(order_id)
          @order_id = order_id.to_s
        end

        def amount=(amount)
          @amount = amount.to_i
        end

        private

        def to_hash
          hash = super.merge(
            callBackUrl: @return_url,
            notifyUrl: @notify_url,
            merchantStoreId: config.store_id,
            order: {
              currency: 'TWD',
              merchantOrderNo: @order_id,
              contractNo: config.contract_id,
              tradeType: 'IMMEDIATE',
              orderAmount: @amount,
              rebateNotApplicableAmount: 0,
              orderItems: []
            }
          )
          hash[:order][:orderDesc] = @order_desc if @order_desc
          hash
        end

        def request_action
          'createECOrder'
        end

        def response_klass
          EasyWalletPay::Response::Online::Pay
        end
      end
    end
  end
end
