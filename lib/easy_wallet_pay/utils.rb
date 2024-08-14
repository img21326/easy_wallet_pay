require 'openssl'
require 'base64'

module EasyWalletPay
  class Utils
    def self.sign(input, secret_key)
      input = input.encode('UTF-8')
      sc_id = [secret_key].pack('H*')
      alg = OpenSSL::Digest.new('SHA256')
      sha256_hmac = OpenSSL::HMAC.digest(alg, sc_id, input)
      sha256_hmac.unpack1('H*')
    end
  end
end
