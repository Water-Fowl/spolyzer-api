# frozen_string_literal: true

class GameUnitsFinder
  include BaseFinder
  def initialize(current_user, params = {})
    @current_user = current_user
    @params = params
  end

  def call
    current_units = Unit
                    .joins(:users)
                    .where(users: { id: @current_user.id })

    game_units = GameUnit.where(unit_id: current_units.pluck(:id))

    game_units = by_opponent_users(game_units)
    game_units = by_game_user_count(game_units)
    game_units = by_outcome(game_units)
    game_units = by_created_at(game_units)
  end

  private

  def by_opponent_users(game_units)
    return game_units unless @params[:opponent_users_ids]

    opponent_users_ids = @params[:opponent_users_ids].split(',').map(&:to_i)
    opponent_units = Unit
                     .joins(:users)
                     .where.not(users: { id: @current_user.id })
                     .where(users: { id: opponent_users_ids })

    opponent_game_units = GameUnit.where(unit_id: opponent_units.pluck(:id))

    game_units.where(game_id: opponent_game_units.pluck(:game_id))
  end

  def by_game_user_count(game_units)
    return game_units unless @params[:game_user_count]

    game_units.joins(:unit).where(units: { user_count: @params[:game_user_count] })
  end

  def by_outcome(game_units)
    return game_units if @params[:outcome] == 'all'

    game_units.where(outcome: @params[:outcome])
  end

  def by_created_at(game_units)
    game_units.where(created_at: [Time.parse(@params[:created_after])..Time.parse(@params[:created_before])])
  end
end
