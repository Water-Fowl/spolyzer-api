class Api::V1::UsersController < Api::V1::BaseController

  before_action :find_users_by_name, only: [:search]

  def show
  end

  def search
  end

  def update
    binding.pry
    current_user =
  end

  private def find_users_by_name
    @users = User.where('name LIKE ?', "%#{params[:name]}%")
  end
end
