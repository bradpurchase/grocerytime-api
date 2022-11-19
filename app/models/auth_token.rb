class AuthToken < ApplicationRecord
  belongs_to :client, class_name: ApiClient.to_s
  belongs_to :user

  before_create :generate_access_token
  before_create :cleanup_tokens

  def generate_access_token
    self.access_token = SecureRandom.hex(20)
  end

  def cleanup_tokens
    user.auth_tokens.destroy_by(client_id: client.id, device_name: device_name)
  end
end
