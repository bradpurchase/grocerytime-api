class Api::V2::Auth::IdentityController < Api::V2::BaseController
  def show
    render json: current_user
  end

  def destroy
    render json: current_user.destroy
  end
end
