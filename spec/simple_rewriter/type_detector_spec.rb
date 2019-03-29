require "spec_helper"

describe SimpleRewriter::TypeDetector do
  subject { described_class.call(value) }

  context "when value is numeric" do
    let(:value) { "123" }

    it { expect(subject).to be(Integer) }
  end

  context "when value is float" do
    let(:value) { "0.1" }

    it { expect(subject).to be(Float) }
  end

  context "when value is date" do
    let(:value) { "12.12.2000" }

    it { expect(subject).to be(Date) }
  end
end
