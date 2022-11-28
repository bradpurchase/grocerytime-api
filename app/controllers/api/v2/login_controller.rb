class Api::V2::LoginController < ApplicationController
  include HasClientCredentials

  def create
    if (user = User.valid_credentials(login_params[:email], login_params[:password]))
      sign_in(user)
      # render json:
      render json: {}
    else
      render json: {error: error_message}, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
