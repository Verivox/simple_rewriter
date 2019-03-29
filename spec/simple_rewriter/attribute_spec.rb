require "spec_helper"

describe SimpleRewriter::Attribute do
  subject { described_class.new(value, options).generate }

  context "when value is unsupported" do
    let(:value) { nil }
    let(:options) { nil }

    it "raises error" do
      expect do
        subject
      end.to raise_error(SimpleRewriter::ClassResolver::NotSupportedAttribute)
    end
  end
end
