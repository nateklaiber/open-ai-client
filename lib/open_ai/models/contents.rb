module OpenAi
  module Models
    class Contents
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def each(&block)
        internal_collection.each(&block)
      end

      private
      def internal_collection
        @collection.map { |record| OpenAi::Models::Content.new(record) }
      end
    end
  end
end
