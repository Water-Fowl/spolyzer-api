class Admin::BaseController < ActionController::Base

  protect_from_forgery

  layout 'admin'

  if Rails.env.production? || Rails.env.staging?
    http_basic_authenticate_with name: 'waterfowl', password: 'password'
  end

  def basic_auth_password
    ENV['BASIC_AUTH_PASSWORD'] || 'password'
  end
end
