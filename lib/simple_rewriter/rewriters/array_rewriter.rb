class SimpleRewriter::Rewriters::ArrayRewriter < SimpleRewriter::Rewriters::Base
  def generate
    random_sized_array
  end

  private

  def array
    @_array ||= []
  end

  def random_sized_array
    rand_num.times do
      array << string_generator.generate
    end
    array
  end
end
