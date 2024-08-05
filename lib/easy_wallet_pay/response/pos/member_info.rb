require 'easy_wallet_pay/response/pos/base'

module EasyWalletPay
  module Response
    module Pos
      class MemberInfo < Base
        attr_reader :mem_card_no, :carrier, :print_receipt, :trans_id
      end
    end
  end
end
