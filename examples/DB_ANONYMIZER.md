### Db Anonymizer

```ruby
class DbAnonymizer
  include Mappings

  ProductionRestrictedError = Class.new(StandardError)

  def initialize(bulk_import: true, mappings: CLASSES_WITH_ATTRIBUTES)
    raise_production_error if Rails.env.production?

    @bulk_import = bulk_import
    @mappings = mappings
  end

  def call
    rewrite_attributes
  end

  private

  attr_reader :bulk_import, :mappings

  def rewrite_attributes
    each_batch do |klass, objects, attributes, valid_objects|
      objects.each do |object|
        result = SimpleRewriter.call(record: object, attributes: attributes)
        valid_objects << result.record if result.success?
      end

      klass.bulk_import(valid_objects, on_duplicate_key_update: :all, validate: false) if bulk_import
    end
  end

  def each_batch
    klass_with_config do |klass, attributes|
      klass.find_in_batches(batch_size: 100) do |objects|
        yield(klass, objects, attributes, [])
      end
    end
  end

  def klass_with_config
    mappings.each do |klass, attribute|
      yield(klass.to_s.safe_constantize, attribute)
    end
  end

  def raise_production_error
    raise ProductionRestrictedError, "User force_production option to run it instead"
  end
end
```

1. `klass_with_config` iterates over mappings and yields record class, and attribute to rewrite
2. `each_batch` yields 100 records to rewrite on one batch
3. `rewrite_attributes` calls `SimpleRewriter` with options and does import on 100 records