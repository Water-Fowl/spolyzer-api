class ScoresFinder
  include BaseFinder
  def initialize(params)
    @params = params
  end

  def call
    scores = Score.where(game_id: @params[:game_ids])

    scores = by_shot_type(scores)
    scores = by_net_miss(scores)
  end

  def by_shot_type(scores)
    return scores unless @params[:shot_type_id]

    scores.where(shot_type_id: @params[:shot_type_id])
  end

  def by_net_miss(scores)
    return scores unless @params[:is_net_miss]

    scores.where(is_net_miss: @params[:is_net_miss])
  end

end