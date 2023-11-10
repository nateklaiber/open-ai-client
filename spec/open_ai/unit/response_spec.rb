RSpec.describe(OpenAi::Response) do

  let(:response_headers_path) do
    File.expand_path('../../../data/response_headers.json', __FILE__)
  end

  let(:response_headers) do
    MultiJson.load(File.read(response_headers_path))
  end

  let(:faraday_env) do
    Faraday::Env.new(response_headers: response_headers.to_hash)
  end

  let(:faraday_stub) do
    double(:faraday_response, env: faraday_env)
  end

  let(:faraday_response) do
    Faraday::Response.new(faraday_env)
  end

  subject { described_class.new(faraday_response) }

  it "returns the request_id" do
    expect(subject.request_id).to eq('15aecde2badf2fa1395d5324345')
  end

  it "returns the rate_limit_attributes" do
    expected = [{"type"=>"x-ratelimit-limit-requests", "value"=>5000}, {"type"=>"x-ratelimit-limit-tokens", "value"=>80000}, {"type"=>"x-ratelimit-remaining-requests", "value"=>4999}, {"type"=>"x-ratelimit-remaining-tokens", "value"=>79968}, {"type"=>"x-ratelimit-reset-requests", "value"=>"12ms"}, {"type"=>"x-ratelimit-reset-tokens", "value"=>"24ms"}]

    expect(subject.rate_limit_attributes).to eq(expected)
  end
end
