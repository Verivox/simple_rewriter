class SimpleRewriter::Rewriters::HashRewriter < SimpleRewriter::Rewriters::Base
  def generate
    return super if any_option_passed?
    random_sized_hash
  end

  private

  def scoped_options
    %i(address deep)
  end

  def random_sized_hash
    {}.tap do |hash|
      rand_num.times do |_i|
        hash[hash_key] = hash_value
      end
    end
  end

  def hash_key
    random_hex(configuration.hash_key_length)
  end

  def hash_value
    string_generator.generate
  end

  def resolve_options_with(values)
    values[0]
  end

  def random_deep
    SimpleRewriter.call(record: attr_value, attributes: options[:deep_attributes_map]).record
  end
end
