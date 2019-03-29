require "simple_rewriter/version"

module SimpleRewriter
  autoload :Rewriter, "simple_rewriter/rewriter"
  autoload :Rewriters, "simple_rewriter/rewriters"

  autoload :Reader,  "simple_rewriter/reader"
  autoload :Readers, "simple_rewriter/readers"
  autoload :Attribute, "simple_rewriter/attribute"
  autoload :Writer, "simple_rewriter/writer"

  autoload :Configuration, "simple_rewriter/configuration"
  autoload :TypeDetector, "simple_rewriter/type_detector"
  autoload :ClassResolver, "simple_rewriter/class_resolver"
  autoload :AttributeResolver, "simple_rewriter/attribute_resolver"
  autoload :BaseService, "simple_rewriter/base_service"

  class << self
    def call(record:, attributes:)
      SimpleRewriter::Rewriter.call(record: record, attributes: attributes)
    end

    def configure
      yield(configuration)
    end

    def configuration
      @_configuration ||= SimpleRewriter::Configuration.new
    end
  end
end
