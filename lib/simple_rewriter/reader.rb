class SimpleRewriter::Reader
  INDEX_OF_ATTRIBUTE_NAME = 0

  def self.call(record, attributes)
    new(record, attributes).call { |data| yield(data) }
  end

  def initialize(record, attributes)
    @record = record
    @attributes = attributes
  end

  def call
    attributes.each do |attribute_with_options|
      @attribute_with_options = attribute_with_options

      yield [attribute, attr_value, options]
    end
  end

  private

  attr_reader :record, :attributes, :attribute_with_options

  def attr_value
    reader.call(attribute)
  end

  def reader
    @_reader ||= reader_class.new(record: record)
  end

  def attribute
    attributes_resolver.call(attribute: attribute_with_options).attribute
  end

  def options
    attributes_resolver.call(attribute: attribute_with_options).options
  end

  def attributes_resolver
    SimpleRewriter::AttributeResolver
  end

  def reader_class
    SimpleRewriter::ClassResolver.call(record, "SimpleRewriter::Readers::%{klass}Reader")
  end
end
