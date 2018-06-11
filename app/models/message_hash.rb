class MessageHash
  def initialize(data)
    @data = data
  end

  def self.for(user)
    new("#{user.id}:#{user.full_name}").call
  end

  def call
    digest = OpenSSL::Digest.new('sha256')
    hmac = OpenSSL::HMAC.digest(digest, key, @data)
    Base64.encode64(hmac)
  end

  private

  def key
    Rails.application.credentials[:secret_key_base]
  end
end
