class Api::V2::Auth::LoginController < Api::V2::BaseController
  include HasClientCredentials

  def create
    if (user = User.valid_credentials(params[:email], params[:password]))
      generate_auth_token(user)
      render json: user.auth_tokens.reload.last
    else
      render json: {error: error_message}, status: :unauthorized
    end
  end

  private

  def generate_auth_token(user)
    user.auth_tokens.create!(client: client, device_name: params[:device_name])
  end

  def error_message
    I18n.t("auth.invalid_user_credentials")
  end
end
