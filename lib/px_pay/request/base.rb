# frozen_string_literal: true

require 'faraday'
require 'json'
require 'easy_card_pay/utils'

module PxPay
  module Request
    class Base
      attr_accessor :config

      def initialize(params = nil)
        return unless params.is_a? Hash

        @config = nil
        params.each do |key, value|
          send "#{key}=", value
        end
        post_initialize
      end

      def request
        raise PxPay::Error, 'Missing Merchant Account' unless config&.account
        raise PxPay::Error, 'Missing Store Name' unless config&.store_name

        res = send_request
        raise PxPay::Error, "status: #{res.status}, message: #{res.body}" if res.status != 200

        res_json_body = JSON.parse(res.body)

        response_klass.new(res_json_body, res.body)
      end

      def trade_time=(trade_time)
        @trade_time = if trade_time.is_a? Time
                        trade_time.strftime('%Y%m%d%H%M%S')
                      else
                        trade_time
                      end
      end

      def log_data
        {
          'request_type' => request_type,
          'end_point' => end_point,
          'request_time' => request_time,
          'request_data' => request_data,
          'request_header' => request_header
        }
      end

      private

      def post_initialize
        @config = PxPay::Config.new
      end

      def request_type
        :post
      end

      def hash_string
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def request_action
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def response_klass
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def request_header
        {
          'Content-Type' => 'application/json;charset=utf-8;',
          'PX-MerCode' => config.account,
          'PX-MerEnName' => config.store_name,
          'PX-SignValue' => sign_value
        }
      end

      def request_time
        @request_time ||= Time.now.strftime('%Y%m%d%I%M%S')
      end

      def store_id
        @store_id || config.store_id
      end

      def to_hash
        {
          req_time: request_time
        }
      end

      def conn
        @conn ||= Faraday.new
      end

      def send_request
        conn.send request_type, end_point, request_data, request_header
      end

      def request_data
        return nil unless to_hash

        JSON.dump(to_hash)
      end

      def sign_value
        PxPay::Utils.sign hash_string, config&.secret_key
      end

      def api_host
        config&.api_host
      end

      def end_point
        "#{api_host}/#{request_action}"
      end
    end
  end
end
