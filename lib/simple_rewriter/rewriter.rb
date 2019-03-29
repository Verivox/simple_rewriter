require "ostruct"

module SimpleRewriter
  class Rewriter < BaseService
    def initialize(record:, attributes: [])
      @record = record
      @attributes = attributes
    end

    def call
      rewrite_attributes
      finalize
    end

    private

    attr_reader :record, :attributes

    def rewrite_attributes
      configuration.reader.call(record, attributes) do |attribute, attr_value, options|
        rewrite(attribute, attr_value, options)
      rescue SimpleRewriter::ClassResolver::NotSupportedAttribute
        next
      end
    end

    def rewrite(attribute, attr_value, options = nil)
      new_attr_value = new_value_for(attr_value, options)
      configuration.writer.call(record, attribute, new_attr_value)
    end

    def new_value_for(value, options)
      SimpleRewriter::Attribute.new(value, options).generate
    end

    def finalize
      OpenStruct.new(
        success?: success?,
        record:   record
      )
    end

    def success?
      return true unless saveable?
      record.save
    end

    def saveable?
      return false if record.is_a?(Hash)
      configuration.save
    end

    def configuration
      SimpleRewriter.configuration
    end
  end
end
