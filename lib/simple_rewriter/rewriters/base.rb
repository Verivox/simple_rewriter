require "faker"

class SimpleRewriter::Rewriters::Base
  include SimpleRewriter::Rewriters::Generators
  include SimpleRewriter::Rewriters::OptionsResolver

  REGISTERED_OPTIONS = %i(email address hex name first_name last_name phonenumber zip street city date
                          sample_pdf deep).freeze

  def initialize(attr_value, options)
    @attr_value = attr_value
    @_options = options
  end

  def generate
    collect_values_from_options
  end

  private

  attr_reader :attr_value

  def scoped_options
    REGISTERED_OPTIONS
  end

  def passed_options
    options.keys.flatten
  end

  REGISTERED_OPTIONS.each do |method_name|
    define_method("#{method_name}?") { options.include?(method_name) }
  end

  def configuration
    SimpleRewriter.configuration
  end

  def options
    @_options ||= []
  end
end
