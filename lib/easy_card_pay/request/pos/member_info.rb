# frozen_string_literal: true

require 'easy_card_pay/request/pos/base'
require 'easy_card_pay/response/pos/member_info'

module EasyCardPay
  module Request
    module Pos
      class MemberInfo < Base
        attr_writer :pay_token

        private

        def to_hash
          super.merge(
            pay_token: @pay_token
          )
        end

        def request_action
          'MemberInfo'
        end

        def request_type
          :post
        end

        def hash_string
          [@pay_token, @request_time].join
        end
      end
    end
  end
end
