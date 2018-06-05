class ScoreSerializer < ActiveModel::Serializer
  attributes :id, :shot_type_id, :dropped_side, :position_id, :is_net_miss, :counts

  def counts
    instance_options[:counts]
  end
end
