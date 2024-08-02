# frozen_string_literal: true

require_relative 'response/online/pay'
require_relative 'response/online/query'
require_relative 'response/online/refund'
require_relative 'response/online/notify'
require_relative 'response/online/order_status'

require_relative 'response/pos/pay'
require_relative 'response/pos/query'
require_relative 'response/pos/refund'
require_relative 'response/pos/reversal'

module PxPay
  module Response
  end
end
