require 'openssl'

module PxPay
  class Utils
    def self.sign(plaintext, secret_key)
      data = plaintext.encode('UTF-8')
      key = [secret_key].pack('H*')
      hash_result = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), key, data)
      hash_result.upcase
    end
  end
end
