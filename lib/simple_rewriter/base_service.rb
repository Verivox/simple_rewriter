class SimpleRewriter::BaseService
  def self.call(*args)
    new(*args).call
  end
end
