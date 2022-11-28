module Authable
  extend ActiveSupport::Concern

  included do
    def self.valid_credentials(email, password)
      user = find_by(email: email)
      user&.password_is_valid?(password) ? user : nil
    end

    def password_is_valid?(check_password)
      BCrypt::Password.new(password) == check_password
    end
  end
end
