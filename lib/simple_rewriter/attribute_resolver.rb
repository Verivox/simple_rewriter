module SimpleRewriter
  class AttributeResolver < BaseService
    def initialize(attribute:)
      @attribute = attribute
    end

    def call
      finalize
    end

    private

    INDEX_OF_ATTRIBUTE_NAME = 0
    private_constant :INDEX_OF_ATTRIBUTE_NAME

    attr_reader :attribute

    def options
      return extract_options if attribute.is_a?(Hash)
    end

    def extract_options
      options = attribute.values

      return options[0] if options[0].is_a?(Hash)
      return convert_array_options(options.flatten) if options.is_a?(Array)

      options.flatten
    end

    def convert_array_options(array)
      array.each_with_object({}) { |option, obj| converted_option(option, obj) }
    end

    def converted_option(option, obj)
      return obj[option.keys[0]] = option.values[0] if option.is_a?(Hash)

      obj[option] = true
    end

    def extracted_attribute
      return attribute.keys[INDEX_OF_ATTRIBUTE_NAME] if attribute.is_a?(Hash)

      attribute
    end

    def finalize
      OpenStruct.new(attribute: extracted_attribute, options: options)
    end
  end
end
