module RequestMacros
  def self.included(base)
    base.extend(ClassMethods)
  end
  module ClassMethods
  end
end
