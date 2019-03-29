module SimpleRewriter
  class Writer < BaseService
    def initialize(record, attribute, new_attr_value)
      @record = record
      @attribute = attribute
      @new_attr_value = new_attr_value
    end

    def call
      write_attribute
    end

    private

    attr_reader :record, :attribute, :new_attr_value

    def write_attribute
      return write_hash_attribute if record.is_a?(Hash)
      write_by_method
    end

    def write_hash_attribute
      record[attribute.to_s] = new_attr_value
    end

    def write_by_method
      record.send("#{attribute}=", new_attr_value)
    end
  end
end
