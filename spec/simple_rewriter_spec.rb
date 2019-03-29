require "spec_helper"

describe SimpleRewriter do
  let(:record) { OpenStruct.new(attribute: attribute, "attribute=": true) }
  let(:email_regex) { /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  %i(email address hex name first_name last_name phonenumber zip street city date sample_pdf).each do |option|
    context "with option #{option}" do
      let(:attribute) { "" }
      let(:attributes) { { attribute: [option] } }

      subject { described_class.call(record: record, attributes: [attributes]) }

      it "generates output" do
        expect(subject.record.attribute).not_to be_empty
        expect(subject.success?).to eq(true)
      end
    end
  end

  [1, {}, rand].each do |attr|
    context "rewrites #{attr.class}" do
      let(:attribute) { attr }

      subject { described_class.call(record: record, attributes: [:attribute]) }

      it do
        expect(record).to receive(:attribute).at_least(:once).and_call_original

        expect(subject.success?).to eq(true)
      end
    end
  end

  context "default value" do
    let(:attribute) { "example" }

    it do
      expect(record).to receive(:attribute).at_least(:once).and_call_original

      result = described_class.call(record: record, attributes: [{ attribute: { default: [] } }])

      expect(result.success?).to eq(true)
      expect(result.record.attribute).to be_a_kind_of(Array)
    end
  end

  context "configuration" do
    let(:user) { OpenStruct.new(created_at: "example", save: true) }

    context "when save is disabled" do
      before { SimpleRewriter.configure { |config| config.save = false } }

      it "doesnt save given record" do
        expect(user).not_to receive(:save)

        expect(described_class.call(record: user, attributes: [:created_at]).success?).to eq(true)
      end
    end

    context "when save is enabled" do
      before { SimpleRewriter.configure { |config| config.save = true } }

      it "doesnt save given record" do
        expect(user).to receive(:save).and_return(true)

        expect(described_class.call(record: user, attributes: [:created_at]).success?).to eq(true)
      end
    end
  end

  context "deep structures" do
    let(:record) do
      hash = {}
      hash["first_key"] = {}
      hash["first_key"]["second_key"] = {}
      hash["first_key"]["second_key"]["third_key"] = "deep_value"
      hash
    end
    let(:attributes) do
      [{
        first_key: {
          deep:                true,
          deep_attributes_map: [{
            second_key: {
              deep:                true,
              deep_attributes_map: [{
                third_key: :email
              }]
            }
          }]
        }
      }]
    end

    it "rewrites only deep nested value" do
      result = described_class.call(record: record, attributes: attributes)

      expect(result.record["first_key"]["second_key"]["third_key"]).to match(email_regex)
    end
  end
end
