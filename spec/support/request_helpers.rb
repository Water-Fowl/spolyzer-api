module RequestHelpers
  def json
    JSON.parse(response.body)
  end
  def headers
    headers = {
      ACCEPT: "application/json", HTTP_ACCEPT: "application/json"
    }
    binding.pry
    auth_header = @user.create_new_auth_token
    headers.merge! auth_header
  end
end
