module SimpleRewriter
  class TypeDetector < BaseService
    def initialize(attr_value)
      @attr_value = attr_value
    end

    def call
      detect_type
    end

    private

    attr_reader :attr_value

    def detect_type
      return Integer if integer?
      return Date if date?
      return Float if float?
    end

    def integer?
      return attr_value.match?(/\A[-+]?[0-9]+\z/) if attr_value.respond_to?(:match?)
      false
    end

    def date?
      Date.parse(attr_value) if string?
    rescue ArgumentError
      false
    end

    def float?
      return attr_value.match?(/[0-9]+[.]{1}[0-9]+/) if attr_value.respond_to?(:match?)
      false
    end

    def string?
      attr_value.is_a?(String)
    end
  end
end
