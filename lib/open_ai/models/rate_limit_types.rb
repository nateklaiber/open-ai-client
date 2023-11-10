module OpenAi
  module Models
    class RateLimitTypes
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def self.list(params={})
        request = OpenAi::Requests::RateLimitTypes.list(params)

        return self.new(request)
      end

      def self.retrieve(id, params={})
        request = OpenAi::Requests::RateLimitTypes.retrieve(id, params)

        if !request.nil?
          return OpenAi::Models::RateLimitType.new(request)
        else
          return nil
        end
      end

      def self.header_keys
        records = self.list
        records.header_keys
      end

      def each(&block)
        internal_collection.each(&block)
      end

      def header_keys
        self.map(&:to_header_key)
      end

      private
      def internal_collection
        @collection.map { |record| OpenAi::Models::RateLimitType.new(record) }
      end
    end
  end
end
