require 'easy_card_pay/response/pos/base'

module PxPay
  module Response
    module Pos
      class MemberInfo < Base
        attr_reader :mem_card_no, :carrier, :print_receipt, :trans_id
      end
    end
  end
end
