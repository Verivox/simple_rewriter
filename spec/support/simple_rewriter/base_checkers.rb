module SimpleRewriter::BaseCheckers
  def check_address_expectations
    expect(Faker::Address).to receive(:street_address).and_call_original
    expect(Faker::Address).to receive(:city).and_call_original
    expect(Faker::Address).to receive(:zip).and_call_original
  end

  def check_base_expectations(klass)
    expect(subject).to be_a_kind_of(klass)
    expect(subject).not_to eq(value)
  end
end
