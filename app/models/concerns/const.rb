module Const
  extend ActiveSupport::Concern
  def term_const(id)
    case id
    when 0
      1.day
    when 1
      1.week
    when 2
      1.month
    end
  end
end
