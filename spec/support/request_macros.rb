module RequestMacros
  def self.included(base)
    base.extend(ClassMethods)
  end
end
