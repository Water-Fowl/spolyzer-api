# frozen_string_literal: true

class ShotTypeSerializer < ActiveModel::Serializer
  attributes :id, :sport_id, :name_ja, :name_en
end
