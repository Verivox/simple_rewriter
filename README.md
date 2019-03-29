
[![Gem Version](https://badge.fury.io/rb/simple_rewriter.svg)](https://badge.fury.io/rb/simple_rewriter)
[![CircleCI](https://circleci.com/gh/Verivox/simple_rewriter.svg?style=svg)](https://circleci.com/gh/Verivox/simple_rewriter)

## Simple Rewriter
   As usually staging and production databases are different from each other, so testing new features on staging database can be painful because of lack of data, and diferrences of data.

   Simple Rewriter enables ability to anonymize whole database with simply mappings, you can use dump production data to have production-like data on staging database without worrying about personal data.

### Instalation
```
gem install simple_rewriter
```
Or in gemfile

```ruby
gem "simple_rewriter", "~> 0.0.2"
```

### Sample usage:
```ruby
SimpleRewriter.call(
  record: user, 
  attributes: [
    :created_at, 
    { token: :hex },
    { email_field: :email },
    { address_field: :address },
    { hash_field: [:deep, :detect_type] },
    { remote_file_urls: { sample_pdf: true, default: [] } # carrierwave support
  ]
)
```

| Options         | Expected Output |
|-----------------|-----------------|
|   :email	      | eac94f-example@domain.com |
|   :address	    | {:street=>\"137 Fahey Street\", :city=>\"New Terryville\", :zip=>\"30752\"} |
|   :hex	        | 6fe6a2485164f0 |
|   :name	        | Evie Upton |
|   :first_name	  | Evie |
|   :last_name	  | Upton |
|   :phonenumber	| 333-333-3333 |
|   :zip	        | 58517 |
|   :street	      | 282 Kevin Brook |
|   :city	        | Imogeneborough |
|   :date	        | 1972-01-02 01:23:21 +0100 | 
|   :sample_pdf	  | http://www.africau.edu/images/default/sample.pdf |
|   :deep	        | nil _Only used to trigger rewriter to go deeper into record_ |
|   :deep_attributes_map | nil _Used to map deeper attributes of record_ |

Options can be joined for e.g. passing `[:first_name, :last_name]` will give the same as `[:name]`

### Configuration

Prevent rewriter from saving record
```ruby

SimpleRewriter.configure do |config|
  config.save = false
end
```

Custom seeds
```ruby
SimpleRewriter.configure do |config|
  config.integer_range = 0..10
  config.hash_key_length = 5
  config.rand_num_max = 10
  config.address = nil # override default address generator as hash with values
end
```

Custom readers/writers
```ruby
SimpleRewriter.configure do |config|
  config.reader = SimpleRewriter::Reader
  config.writer = SimpleRewriter::Writer
end
```

Sample Pdf url
```ruby
SimpleRewriter.configure do |config|
  config.sample_pdf_url = "http://www.africau.edu/images/default/sample.pdf"
end
```

### Examples
Real [anonymizer](/examples/DB_ANONYMIZER.md) configured with sample mappings for batch updates.

### Contributing
We use PORO to keep dependieces clear and simple.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Running tests
```ruby
bundle install
bin/rspec
```

### Authors

> [jcapt](https://github.com/jcapt) &nbsp;&middot;&nbsp;
> [PiotrMisiurek](https://github.com/PiotrMisiurek) &nbsp;&middot;&nbsp;
> [michalsz](https://github.com/michalsz)

---

Licensed under MIT by the Verivox GmbH
