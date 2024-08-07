# frozen_string_literal: true

require 'cgi'
require 'digest'

module EasyWalletPay
  module Response
    class Base
      attr_reader :raw, :status_code, :message

      def initialize(raw)
        @raw = raw
        @status_code = json_data&.dig('returnCode')
        @message = json_data&.dig('returnMsg')
      end

      def status
        return @status_code unless @status_code.nil?

        nil
      end

      def success?
        return false unless @status_code

        @status_code == '00000'
      end

      def order_status
        data&.dig('orderStatus')
      end

      def is_paid?
        %w[PAYMENT_RECEIVED COMPLETED].include?(order_status)
      end

      def is_refund?
        %w[REFUND_COMPLETED ORDER_CANCEL].include?(order_status)
      end

      private 

      def json_data
        @json_data ||= JSON.parse(raw)
      rescue StandardError
        nil
      end

      def data
        json_data&.dig('data')
      end
    end
  end
end
