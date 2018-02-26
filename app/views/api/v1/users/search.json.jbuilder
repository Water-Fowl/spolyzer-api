json.users @users do |user|
  json.user user, :name, :email, :image
end
