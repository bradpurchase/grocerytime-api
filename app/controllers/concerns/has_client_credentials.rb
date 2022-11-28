module HasClientCredentials
  extend ActiveSupport::Concern

  included do
    before_action :validate_credentials
  end

  def validate_credentials
    return if ApiClient.exists?(key: client_credentials[0], secret: client_credentials[1])
    render json: {error: error_message}, status: :unauthorized
  end

  def error_message
    I18n.t("auth.invalid_client_credentials")
  end

  def client_credentials
    request.headers.fetch("Authorization", "").split(":")
  end
end
