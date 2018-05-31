class GameSerializer < ActiveModel::Serializer
  attributes :id, :sport_id, :name, :record_user_id, :score_count

  def score_count
    object.score_count
  end

end
