require "spec_helper"

describe SimpleRewriter::Rewriters::StringRewriter do
  subject { described_class.new(value, options).generate }
  let(:email_regex) { /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  let(:value) { "example" }

  describe "#generate" do
    context "without options" do
      let(:options) { {} }

      it("generates new value") { check_base_expectations(String) }
    end

    context "with email option" do
      let(:options) { { email: true } }

      it "generates new value" do
        check_base_expectations(String)
        expect(subject).to match(email_regex)
      end
    end

    context "with address option" do
      let(:options) { { address: true } }

      it "generates new value" do
        check_address_expectations
        check_base_expectations(String)
      end
    end

    context "with hex option" do
      let(:options) { { hex: true } }

      it "generates new value" do
        expect(SecureRandom).to receive(:hex).and_call_original
        check_base_expectations(String)
      end
    end

    context "with name option" do
      let(:options) { { name: true } }

      it "generates new value" do
        expect(Faker::Name).to receive(:name).and_call_original
        check_base_expectations(String)
      end
    end

    context "with name option" do
      let(:options) { { sample_pdf: true } }

      it "generates new value" do
        check_base_expectations(String)
        expect do
          URI.parse(subject)
        end.not_to raise_error
      end
    end
  end
end
