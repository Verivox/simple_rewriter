module SimpleRewriter::Rewriters
  autoload :Base, "simple_rewriter/rewriters/base"
  autoload :ArrayRewriter, "simple_rewriter/rewriters/array_rewriter"
  autoload :DateRewriter, "simple_rewriter/rewriters/date_rewriter"
  autoload :FloatRewriter, "simple_rewriter/rewriters/float_rewriter"
  autoload :HashRewriter, "simple_rewriter/rewriters/hash_rewriter"
  autoload :IntegerRewriter, "simple_rewriter/rewriters/integer_rewriter"
  autoload :StringRewriter, "simple_rewriter/rewriters/string_rewriter"
  autoload :ActiveSupport, "simple_rewriter/rewriters/active_support"
  autoload :Generators, "simple_rewriter/rewriters/generators"
  autoload :OptionsResolver, "simple_rewriter/rewriters/options_resolver"
end
