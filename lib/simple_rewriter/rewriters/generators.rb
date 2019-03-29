module SimpleRewriter::Rewriters::Generators
  def random_sample_pdf
    configuration.sample_pdf_url
  end

  def random_address
    configuration.address || default_address
  end

  def default_address
    {
      street: random_street,
      city:   random_city,
      zip:    random_zip
    }
  end

  def random_name
    Faker::Name.name
  end

  def random_email
    "#{random_hex(5)}-#{Faker::Internet.email}"
  end

  def random_first_name
    Faker::Name.first_name
  end

  def random_last_name
    Faker::Name.last_name
  end

  def random_phonenumber
    Faker::PhoneNumber.phone_number
  end

  def random_hex(hex_length = nil)
    SecureRandom.hex(hex_length)
  end

  def random_zip
    Faker::Address.zip
  end

  def random_city
    Faker::Address.city
  end

  def random_street
    Faker::Address.street_address
  end

  def random_date
    date_generator.generate
  end

  def rand_num
    SecureRandom.random_number(configuration.rand_num_max)
  end

  def string_generator
    @_string_generator ||= SimpleRewriter::Rewriters::StringRewriter.new(attr_value, options)
  end

  def date_generator
    @_date_generator ||= SimpleRewriter::Rewriters::DateRewriter.new(attr_value, options)
  end
end
