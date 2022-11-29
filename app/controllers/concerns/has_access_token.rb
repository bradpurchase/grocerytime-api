module HasAccessToken
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user

    before_action :validate_bearer_token
  end

  def validate_bearer_token
    token = AuthToken.find_by(access_token: bearer_token)
    return render json: {error: error_message}, status: :unauthorized if token.nil?
    @current_user = token.user
  end

  def error_message
    I18n.t("auth.invalid_bearer_token")
  end

  def bearer_token
    request.headers.fetch("Authorization", "").split("Bearer ")[1]
  end
end
