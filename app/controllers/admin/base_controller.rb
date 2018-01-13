class Admin::BaseController < ActionController::Base
  if Rails.env.production? || Rails.env.staging?
    http_basic_authenticate_with name: 'waterfowl', password: basic_auth_password
  end

  def basic_auth_password
    ENV['BASIC_AUTH_PASSWORD'] || 'password'
  end
end
