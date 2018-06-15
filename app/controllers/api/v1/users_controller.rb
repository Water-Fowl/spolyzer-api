# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::BaseController
  def index
    render json: current_api_v1_user
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    current_api_v1_user.update(user_params)
    render json: current_api_v1_user
  end

  private

  def user_params
    user_params = params.permit(
      :name,
      :email,
      :image,
      :sport_id
    )

    user_params[:image] = parse_image_data(user_params[:image]) if user_params[:image]
    user_params
  end

  def parse_image_data(base64_image)
    filename = 'profile-image'
    in_content_type, _, string = base64_image.split(/[:;,]/)[1..3]

    @tempfile = Tempfile.new(filename)
    @tempfile.binmode
    @tempfile.write Base64.decode64(string)
    @tempfile.rewind

    ActionDispatch::Http::UploadedFile.new(
      tempfile: @tempfile,
      content_type: in_content_type,
      filename: filename
    )
  end
end
