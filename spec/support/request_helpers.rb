# frozen_string_literal: true

module RequestHelpers
  def json
    JSON.parse(response.body)
  end
end
