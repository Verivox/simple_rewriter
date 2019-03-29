module SimpleRewriter
  module Readers
    class BaseReader
      def initialize(record:)
        @record = record
      end

      def call(attribute)
        read_attribute(attribute)
      end

      private

      attr_reader :record

      def read_attribute(_attribute)
        raise NotImplementedError
      end
    end
  end
end
