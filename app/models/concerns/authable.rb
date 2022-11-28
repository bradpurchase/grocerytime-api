module Authable
  extend ActiveSupport::Concern

  included do
    def self.valid_credentials(email, password)
      user = find_by(email: email)
      return false if user.nil?
      user.password_is_valid?(login_params[:password]) ? user : nil
    end

    def self.password_is_valid?(password)
      password == BCrypt::Password.new(user.password)
    end
  end
end
