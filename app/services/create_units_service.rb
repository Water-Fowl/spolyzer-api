# frozen_string_literal: true

class CreateUnitsService
  include BaseService
  attr_reader :params

  def initialize(params, game_id)
    @params = params
    @game_id = game_id
  end

  def call
    left_unit = create_units(:left)
    right_unit = create_units(:right)
    [left_unit, right_unit]
  end

  private

  def create_units(side)
    unit = find_or_create_with_users(side)
    unit.game_units.create(game_id: @game_id, side: side)
    unit
  end

  def set_users(side)
    user_count = params[side][:count]
    users = []
    user_count.times do |i|
      user = params[side][:users][i]
      users.push(User.find(user[:id]))
    end
    users
  end

  def find_or_create_with_users(side)
    users = set_users(side)
    unit = Unit.of_users(users).where(user_count: params[side][:count]).first

    unless unit
      unit = Unit.create(user_count: users.count)
      users.each do |user|
        unit.user_units.create(user_id: user[:id])
      end
    end

    unit
  end
end
