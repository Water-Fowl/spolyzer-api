class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!

  def search_user_by_id
      params_name = params.require(:data).permit(:name)
      @name = params[:name]
      users = User.where('name LIKE ?', "%#{@name}%")
      if not users.empty?
        render json: {status:0, message:"ok", is_exist: true, users: users}
      else
        render json: {status:0, message:"ok", is_exist: false}
      end
  end
end
