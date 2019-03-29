require "spec_helper"

describe SimpleRewriter::Rewriters::HashRewriter do
  subject { described_class.new(value, options).generate }
  let(:value) { { example: "example" } }

  describe "#generate" do
    context "without options" do
      let(:options) { {} }

      it "generates new hash" do
        check_base_expectations(Hash)
      end
    end

    context "with address option" do
      let(:options) { { address: true } }

      it "generates new hash" do
        check_address_expectations
        check_base_expectations(Hash)
      end
    end
  end
end
