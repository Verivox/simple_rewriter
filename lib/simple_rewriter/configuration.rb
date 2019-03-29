class SimpleRewriter::Configuration
  attr_accessor :save, :integer_range, :hash_key_length, :hash_value_length, :rand_num_max, :address,
                :reader, :writer, :sample_pdf_url

  def initialize
    @reader = SimpleRewriter::Reader
    @writer = SimpleRewriter::Writer
    @save = false
    @integer_range = 0..10
    @hash_key_length = 5
    @rand_num_max = 10
    @address = nil
    @sample_pdf_url = "http://www.africau.edu/images/default/sample.pdf"
  end
end
