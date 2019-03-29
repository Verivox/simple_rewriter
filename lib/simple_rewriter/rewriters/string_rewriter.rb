require "faker"

class SimpleRewriter::Rewriters::StringRewriter < SimpleRewriter::Rewriters::Base
  def generate
    return super if any_option_passed?
    random_text
  end

  private

  def scoped_options
    REGISTERED_OPTIONS - [:deep]
  end

  def random_text
    "#{random_hex(5)}-#{Faker::Quote.famous_last_words}"
  end
end
