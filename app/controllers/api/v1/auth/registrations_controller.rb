class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :authenticate_user
  def sign_up_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
