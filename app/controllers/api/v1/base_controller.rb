class Api::V1::BaseController < ApplicationController
  before_action :authenticate_api_v1_user!
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :null_session
end
