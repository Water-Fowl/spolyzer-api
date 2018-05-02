# frozen_string_literal: true

module RequestMacros
  def self.included(base)
    base.extend(ClassMethods)
  end
  module ClassMethods
  end
end
