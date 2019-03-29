class SimpleRewriter::Rewriters::FloatRewriter < SimpleRewriter::Rewriters::Base
  def generate
    random_float
  end

  private

  # rand generates pseudo random from 0-1
  # rand(10) generates pseudo random from 0-10
  # we use it to get something like 4.41445946155691
  def random_float
    rand * rand(10)
  end
end
