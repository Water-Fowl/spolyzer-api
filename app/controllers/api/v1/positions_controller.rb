class Api::V1::PositionsController < Api::V1::BaseController

  def counts
    count_runs_scored, count_runs_against = CountPositionsService.new(params, current_api_v1_user).execute
    @counts = {}
    @counts[0] = count_runs_against
    @counts[1] = count_runs_scored
  end
end
