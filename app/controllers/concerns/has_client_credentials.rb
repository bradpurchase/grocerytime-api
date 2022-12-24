module HasClientCredentials
  extend ActiveSupport::Concern

  included do
    attr_reader :client

    skip_before_action :validate_bearer_token

    before_action :validate_credentials
  end

  def validate_credentials
    @client = ApiClient.find_by(key: client_credentials[0], secret: client_credentials[1])
    return render json: {error: error_message}, status: :unauthorized if @client.nil?
    @client
  end

  def error_message
    I18n.t("auth.invalid_client_credentials")
  end

  def client_credentials
    request.headers.fetch("Authorization", "").split(":")
  end
end
