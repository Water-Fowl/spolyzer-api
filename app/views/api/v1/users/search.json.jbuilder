# frozen_string_literal: true

json.users @users do |user|
  json.user user, :id, :name, :email, :image
end
