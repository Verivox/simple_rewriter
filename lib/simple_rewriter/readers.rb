module SimpleRewriter::Readers
  autoload :BaseReader, "simple_rewriter/readers/base_reader"
  autoload :ActiveRecordReader, "simple_rewriter/readers/active_record_reader"
  autoload :HashReader, "simple_rewriter/readers/hash_reader"
  autoload :OpenStructReader, "simple_rewriter/readers/open_struct_reader"
end
