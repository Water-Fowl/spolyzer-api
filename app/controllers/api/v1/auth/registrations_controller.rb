class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  def sign_up_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def create
    @user = User.new(sign_up_params)
    @user.skip_confirmation!
    if @user.save
    end
  end
end
