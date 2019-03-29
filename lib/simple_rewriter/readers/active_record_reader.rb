module SimpleRewriter
  module Readers
    class ActiveRecordReader < BaseReader
      private

      def read_attribute(attribute)
        record.send(attribute)
      end
    end
  end
end
