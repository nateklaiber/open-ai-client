RSpec.describe(OpenAi::Models::RateLimitTypes) do
  let(:rate_limit_attributes) do
    [
      {"type"=>"x-ratelimit-limit-requests", "value"=>5000},
      {"type"=>"x-ratelimit-limit-tokens", "value"=>80000},
      {"type"=>"x-ratelimit-remaining-requests", "value"=>4999},
      {"type"=>"x-ratelimit-remaining-tokens", "value"=>79968},
      {"type"=>"x-ratelimit-reset-requests", "value"=>"12ms"},
      {"type"=>"x-ratelimit-reset-tokens", "value"=>"24ms"}
    ]
  end

  subject { described_class.new(rate_limit_attributes) }

  it "returns the total count" do
    expect(subject.count).to eq(6)
  end

  it "returns the rate limit for requests" do
    expect(described_class.retrieve('x-ratelimit-limit-requests')).to be_kind_of(OpenAi::Models::RateLimitType)
  end

  it "returns nil if record not found" do
    expect(described_class.retrieve('x-ratelimit-limit-requests-NOTFOUND')).to be_nil
  end
end
