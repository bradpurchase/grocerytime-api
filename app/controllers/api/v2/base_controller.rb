class Api::V2::BaseController < ApplicationController
  include HasAccessToken

  skip_before_action :verify_authenticity_token
end
