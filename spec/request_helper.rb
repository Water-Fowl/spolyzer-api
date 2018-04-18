module RequestHelpers
  def json
    JSON.parse(response.body)
  end
  def headers
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    auth_header = @user.create_new_auth_token
    binding.pry
    headers.merge! auth_header
    headers
  end
end
