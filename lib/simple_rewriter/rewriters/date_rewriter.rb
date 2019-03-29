class SimpleRewriter::Rewriters::DateRewriter < SimpleRewriter::Rewriters::Base
  def generate
    random_date
  end

  private

  def random_date
    Time.at(rand * Time.now.to_i)
  end
end
