# frozen_string_literal: true

# Base Controller requires authentication
class Api::V1::BaseController < ActionController::Api
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_api_v1_user!
end
