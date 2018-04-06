class BaseService
  def self.execute(*args)
    new(*args).execute
  end
end
