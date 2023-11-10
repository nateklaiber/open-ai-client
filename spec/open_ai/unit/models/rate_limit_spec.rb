RSpec.describe(OpenAi::Models::RateLimit) do

  subject { described_class.new(rate_limit_attributes) }

  context "with each unit type" do
    let(:rate_limit_attributes) do
      {"type"=>"x-ratelimit-limit-requests", "value"=>5000}
    end

    it "returns the type name" do
      expected = 'x-ratelimit-limit-requests'
      expect(subject.type_value).to eq(expected)
    end

    it "returns the description" do
      expected = 'The maximum number of requests that are permitted before exhausting the rate limit.'
      expect(subject.description).to eq(expected)
    end

    it "returns the unit_value" do
      expected = 'each'
      expect(subject.unit_value).to eq(expected)
    end

    it "returns the unit_type" do
      expected = 'each'
      expect(subject.unit_type).to eq(expected)
    end

    it "returns the unit_object" do
      expected = '5000 each'
      expect(subject.unit_object).to eq(expected)
    end

    it "returns the unit_object class" do
      expect(subject.unit_object).to be_kind_of(RubyUnits::Unit)
    end
  end

  context "with time unit_type" do
    let(:rate_limit_attributes) do
      {"type"=>"x-ratelimit-reset-requests", "value"=>"5h30m33ms"}
    end

    it "returns the unit_type" do
      expected = 'time'
      expect(subject.unit_type).to eq(expected)
    end

    it "returns the unit_object" do
      expected = '19800033 ms'
      expect(subject.unit_object).to eq(expected)
    end

    it "returns the unit_object class" do
      expect(subject.unit_object).to be_kind_of(RubyUnits::Unit)
    end
  end

  context "with only milliseconds" do
    let(:rate_limit_attributes) do
      {"type"=>"x-ratelimit-reset-requests", "value"=>"300ms"}
    end

    it "returns the unit_object" do
      expected = '300 ms'
      expect(subject.unit_object).to eq(expected)
    end

    it "returns the unit_object class" do
      expect(subject.unit_object).to be_kind_of(RubyUnits::Unit)
    end
  end

  context "with only seconds" do
    let(:rate_limit_attributes) do
      {"type"=>"x-ratelimit-reset-requests", "value"=>"34s"}
    end

    it "returns the unit_object" do
      expected = '34000 ms'
      expect(subject.unit_object).to eq(expected)
    end

    it "returns the unit_object class" do
      expect(subject.unit_object).to be_kind_of(RubyUnits::Unit)
    end
  end

  context "with only minutes" do
    let(:rate_limit_attributes) do
      {"type"=>"x-ratelimit-reset-requests", "value"=>"12m"}
    end

    it "returns the unit_object" do
      expected = '720000 ms'
      expect(subject.unit_object).to eq(expected)
    end

    it "returns the unit_object class" do
      expect(subject.unit_object).to be_kind_of(RubyUnits::Unit)
    end
  end
end
