class Api::V1::UsersController < Api::V1::BaseController

  before_action :find_users_by_name, only: [:search]

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def search
  end

  def update
    current_api_v1_user.update(user_params)
  end

  private def find_users_by_name
    @users = User.where('name LIKE ?', "%#{params[:name]}%")
  end

  private def user_params
    params.permit(
     :name,
     :email,
     :image
   )
  end
end
