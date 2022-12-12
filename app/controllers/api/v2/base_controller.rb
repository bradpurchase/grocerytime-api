class Api::V2::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
end
