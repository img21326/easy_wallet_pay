# frozen_string_literal: true

require 'easy_card_pay/request/online/base'
require 'easy_card_pay/response/online/refund'
require 'time'

module EasyCardPay
  module Request
    module Online
      class Refund < Base
        attr_writer :remark1, :remark2, :remark3

        def bank_trade_id=(bank_trade_id)
          @bank_trade_id = bank_trade_id.to_s
        end

        def order_id=(order_id)
          @order_id = order_id.to_s
        end

        def refund_order_id=(refund_order_id)
          @refund_order_id = refund_order_id.to_s
        end

        def amount=(amount)
          @amount = amount.to_i
        end

        private

        def to_hash
          super.merge(
            mer_trade_no: @order_id,
            px_trade_no: @bank_trade_id,
            refund_mer_trade_no: @refund_order_id,
            amount: @amount,
            trade_time: @trade_time,
            remark1: @remark1 || '',
            remark2: @remark2 || '',
            remark3: @remark3 || ''
          )
        end

        def response_klass
          EasyCardPay::Response::Online::Refund
        end

        def request_action
          'Refund'
        end

        def hash_string
          [@order_id, @bank_trade_id, @trade_time, @refund_order_id, @amount, request_time].join
        end
      end
    end
  end
end
