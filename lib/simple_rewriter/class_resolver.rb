module SimpleRewriter
  class ClassResolver < BaseService
    NotSupportedAttribute = Class.new(StandardError)

    def initialize(value, guess, options = nil)
      @value = value
      @guess = guess
      @attr_klass = value.class
      @options = options
    end

    def call
      desired_class
    end

    private

    attr_reader :attr_klass, :options, :klass, :guess

    def desired_class
      return klass if detect_type? && try_class(detect_type)
      return klass if default? && try_class(default_class)
      return klass if try_class(attr_klass)
      return SimpleRewriter::Readers::ActiveRecordReader if active_record?

      raise_unsupported_error
    end

    def raise_unsupported_error
      raise NotSupportedAttribute, "Attribute '#{attr_klass}' is not supported (#{string_to_constantize(attr_klass)})"
    end

    def try_class(scoped_klass)
      return false unless result = safe_constantize(string_to_constantize(scoped_klass))
      @klass = result
    end

    def string_to_constantize(scoped_klass)
      guess % { klass: scoped_klass }
    end

    def default_class
      options[:default].class
    end

    def default?
      options && options[:default]
    end

    def detect_type?
      options && options[:detect_type]
    end

    def detect_type
      SimpleRewriter::TypeDetector.call(value)
    end

    def safe_constantize(target)
      Object.const_get(target)
    rescue StandardError
      false
    end

    def active_record?
      attr_klass.is_a?(ActiveRecord::Base) if defined?(ActiveRecord::Base)
    end
  end
end
