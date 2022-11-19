class ApiClient < ApplicationRecord
  before_create :generate_api_keys

  validates :name, presence: true, uniqueness: true
  validates :key, presence: true, uniqueness: true
  validates :secret, presence: true, uniqueness: true

  def generate_api_keys
    self.key = SecureRandom.hex
    self.secret = SecureRandom.hex
  end
end
