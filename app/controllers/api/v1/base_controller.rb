class Api::V1::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  def current_user
    User.first
  end
end
