module OpenAi
  module Requests
    class RateLimitTypes

      def self.list(params={}, &block)
        file_path = File.expand_path('../../../../data/rate_limit_types.json', __FILE__)
        file_contents = File.read(file_path)

        return MultiJson.load(file_contents)
      end

      def self.retrieve(id, params={}, &block)
        file_path = File.expand_path('../../../../data/rate_limit_types.json', __FILE__)
        file_contents = File.read(file_path)

        records =  MultiJson.load(file_contents)
        records.find { |record| record['type'] == id }
      end
    end
  end
end
