require "forwardable"

class SimpleRewriter::Attribute
  extend Forwardable

  def initialize(attr_value, options)
    @attr_value = attr_value
    @options = options
  end

  def_delegator :generator, :generate

  private

  attr_reader :attr_value, :options, :generator_klass

  def generator
    @_generator ||= generator_class.new(attr_value, options)
  end

  def generator_class
    SimpleRewriter::ClassResolver.call(attr_value, "SimpleRewriter::Rewriters::%{klass}Rewriter", options)
  end
end
