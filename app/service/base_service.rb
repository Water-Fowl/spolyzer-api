class BaseService
  def initialize(params)
    @params = params
  end

  def self.execute(*args)
    new(*args).execute
  end
end
