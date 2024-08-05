# frozen_string_literal: true

require 'easy_wallet_pay/request/pos/base'
require 'easy_wallet_pay/response/pos/refund'
require 'time'

module EasyWalletPay
  module Request
    module Pos
      class Refund < Base
        def store_id=(store_id)
          @store_id = store_id.to_s
        end

        def store_name=(store_name)
          @store_name = store_name.to_s
        end

        def pos_id=(pos_id)
          @pos_id = pos_id.to_s
        end

        def trade_number=(trade_number)
          @trade_number = trade_number.to_s
        end

        def refund_trade_number=(refund_trade_number)
          @refund_trade_number = refund_trade_number.to_s
        end

        def bank_transaction_id=(bank_transaction_id)
          @bank_transaction_id = bank_transaction_id.to_s
        end

        def amount=(amount)
          @amount = amount.to_i
        end

        private

        def response_klass
          EasyWalletPay::Response::Pos::Refund
        end

        def to_hash
          super.merge(
            store_id: store_id,
            store_name: @store_name,
            pos_id: @pos_id,
            pos_trade_time: @trade_time,
            ori_mer_trade_no: @trade_number,
            mer_trade_no: @refund_trade_number,
            ori_px_trade_no: @bank_transaction_id,
            none_discount_amount: 0,
            none_feedback_amount: 0,
            amount: @amount
          )
        end

        def request_action
          'Refund'
        end

        def hash_string
          [store_id, @pos_id, @trade_time, @trade_number, @refund_trade_number, @amount,
           request_time].join
        end
      end
    end
  end
end
