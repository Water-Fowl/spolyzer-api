module ShotTypes
  class BaseService < ::BaseService

    def initialize(params, user)
      @params = params
      @user = user
    end

    private
    def reshape(scores)
      if not scores.empty?
        count_positions = scores
          .joins(:position)
          .group('positions.dropped_at')
          .count.reduce({}) do |count, (key, value)|
          dropped_at = key
          count ||= {}
          count[dropped_at] ||= value
          count
        end
      else
        scores
      end
    end
  end
end
