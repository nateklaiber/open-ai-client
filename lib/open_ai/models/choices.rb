module OpenAi
  module Models
    class Choices
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def each(&block)
        internal_collection.each(&block)
      end

      def to_attributes
        Array(self.map(&:to_attributes)).flatten
      end

      private
      def internal_collection
        @collection.map { |record| OpenAi::Models::Choice.new(record) }
      end
    end
  end
end
