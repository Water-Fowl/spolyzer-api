# frozen_string_literal: true

class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  def sign_up_params
    params.permit(:name, :email, :sport_id, :password, :password_confirmation)
  end
end
