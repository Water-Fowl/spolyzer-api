# frozen_string_literal: true

class SportSerializer < ActiveModel::Serializer
  attributes :id, :name_ja, :name_en
end
