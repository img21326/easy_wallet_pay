# frozen_string_literal: true

require 'easy_wallet_pay/request/pos/base'
require 'easy_wallet_pay/response/pos/pay'

module EasyWalletPay
  module Request
    module Pos
      class Pay < Base
        attr_writer :order_desc, :pay_token

        def order_id=(order_id)
          @order_id = order_id.to_s
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
            order: {
              merchantOrderNo: @order_id,
              contractNo: config.contract_id,
              currency: 'TWD',
              tradeType: 'IMMEDIATE',
              orderAmount: @amount,
              rebateNotApplicableAmount: 0,
              paymentBarCode: @pay_token,
              orderItems: [],
              rewardPointsList: []
            }
          )
          hash[:order][:posSN] = @pos_id if @pos_id
          hash[:order][:orderDesc] = @order_desc if @order_desc
          hash
        end

        def response_klass
          EasyWalletPay::Response::Pos::Pay
        end

        def request_action
          'createPOSOrder'
        end
      end
    end
  end
end
