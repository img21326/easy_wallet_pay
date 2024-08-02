# frozen_string_literal: true

require 'easy_card_pay/request/online/base'
require 'easy_card_pay/response/online/pay'

module PxPay
  module Request
    module Online
      class Pay < Base
        attr_writer :web_confirm_url, :web_cancel_url, :app_confirm_url,
                    :app_cancel_url, :notify_url, :status_url

        def order_id=(order_id)
          @order_id = order_id.to_s
        end

        def device_type=(device_type)
          @device_type = {
            pc: 1,
            mobile: 2,
            app: 3
          }[device_type]
          raise ArgumentError, 'device_type must be :pc, :mobile or :app' unless @device_type
        end

        def amount=(amount)
          @amount = amount.to_i
        end

        private

        def to_hash
          hash = super.merge(
            mer_trade_no: @order_id,
            amount: @amount,
            device_type: @device_type,
            store_id: store_id,
          )
          hash[:web_cancel_url] = @web_cancel_url if @web_cancel_url
          hash[:web_confirm_url] = @web_confirm_url if @web_confirm_url
          hash[:app_cancel_url] = @app_cancel_url if @app_cancel_url
          hash[:app_confirm_url] = @app_confirm_url if @app_confirm_url
          hash[:order_status_url] = @status_url if @status_url
          hash[:payment_notify_url] = @notify_url if @notify_url
          hash
        end

        def request_action
          'CreateOrder'
        end

        def response_klass
          PxPay::Response::Online::Pay
        end

        def request_type
          :post
        end

        def hash_string
          [@order_id, @amount, @device_type, request_time, store_id].join
        end
      end
    end
  end
end
