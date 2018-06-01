# frozen_string_literal: true

class Api::V1::Users::SearchController < Api::V1::BaseController
  def index
    @users = User.where('name LIKE ?', "%#{params[:name]}%")
  end
end
