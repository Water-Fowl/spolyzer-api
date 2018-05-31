class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :sport_id, :image
end
