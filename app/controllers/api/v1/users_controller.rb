class Api::V1::UsersController < Api::V1::BaseController

  before_action :find_users_by_name, only: [:search]

  def show
    @user = User.find(params[:id])
  end

  def search
  end

  def update
    if current_user.update(user_params)
      @user = current_user
    end
  end

  private def find_users_by_name
    @users = User.where('name LIKE ?', "%#{params[:name]}%")
  end

  private def user_params
    params.permit(
     :name,
     :email
   )
  end
end
