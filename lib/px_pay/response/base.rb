# frozen_string_literal: true

require 'cgi'
require 'digest'

module PxPay
  module Response
    class Base
      attr_reader :raw, :status_code

      def initialize(params, raw)
        @raw = raw
        params.each_pair do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      def status
        return @status_code unless @status_code.nil?

        nil
      end

      def success?
        return false unless @status_code

        @status_code == '0000'
      end

      def message
        return @status_message unless @status_message.nil?

        nil
      end
    end
  end
end
