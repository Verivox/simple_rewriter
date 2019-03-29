module SimpleRewriter::Rewriters::OptionsResolver
  def any_option_passed?
    scoped_options.any? { |option| send(:"#{option}?") }
  end

  def collect_values_from_options
    values = filtered_options.each_with_object([]) do |option, arr|
      arr << send("random_#{option}") if send(:"#{option}?")
    end

    resolve_options_with(values)
  end

  def filtered_options
    passed_options.select { |option| scoped_options.include?(option) }
  end

  def resolve_options_with(values)
    values.join(" ")
  end
end
