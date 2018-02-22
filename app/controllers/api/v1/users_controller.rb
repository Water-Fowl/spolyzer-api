class Api::V1::UsersController < Api::V1::BaseController

  before_action :find_users_by_name, only: [:search]

  def show
  end

  def search
  end

  def update
    if current_user.update(user_params)
      render :show, status: :success
    else
      render json: { err_msg: current_user.errors.full_messages.join("\n") }, status: :bad_request
    end
  end

  private def find_users_by_name
    @users = User.where('name LIKE ?', "%#{params[:name]}%")
  end

  private def user_params
    params.permit(
     :name
   )
  end
end
