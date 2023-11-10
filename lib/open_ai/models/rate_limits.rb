module OpenAi
  module Models
    class RateLimits
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def each(&block)
        internal_collection.each(&block)
      end

      def retrieve(id)
        self.find { |record| record.id == id }
      end

      private
      def internal_collection
        @collection.map { |record| OpenAi::Models::RateLimit.new(record) }
      end
    end
  end
end
