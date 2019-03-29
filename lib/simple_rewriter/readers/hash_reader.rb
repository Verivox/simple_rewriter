module SimpleRewriter
  module Readers
    class HashReader < BaseReader
      private

      def read_attribute(attribute)
        record[attribute.to_s]
      end
    end
  end
end
