class GameSerializer < ActiveModel::Serializer
  attributes :id, :sport_id, :name, :record_user_id, :score_count, :left_users, :right_users

  def score_count
    object.score_count
  end

  def left_users
    object.units[0].users
  end

  def right_users
    object.units[1].users
  end

end
