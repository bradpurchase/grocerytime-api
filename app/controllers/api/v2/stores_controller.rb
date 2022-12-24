class Api::V2::StoresController < Api::V2::BaseController
  def index
    render json: stores
  end

  private

  def stores
    @stores ||= current_user.stores_including_shared
  end
end
