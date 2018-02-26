class Api::V1::UsersController < Api::V1::BaseController

  before_action :find_users_by_name, only: [:search]

  def show
  end

  def name
  end

  def search
  end

  def update
    current_user.update(user_params)
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
