require "securerandom"

class SimpleRewriter::Rewriters::IntegerRewriter < SimpleRewriter::Rewriters::Base
  def generate
    SecureRandom.random_number(configuration.integer_range)
  end
end
