module RequestHelpers
  def json
    JSON.parse(response.body)
  end
  def headers
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    auth_header = @user.create_new_auth_token
<<<<<<< HEAD
    binding.pry
    headers.merge! auth_header
    headers
=======
    headers.merge! auth_header
>>>>>>> 036f8d77926b6714073c8b4be5a9c042bd57a74c
  end
end
