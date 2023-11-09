module OpenAi
  module Models
    class Links
      include Enumerable

      def initialize(collection)
        @collection = Array(collection)
      end

      def each(&block)
        internal_collection.each(&block)
      end

      def find_by_rel(rel)
        self.find { |record| record.rel == rel }
      end
      alias route_for find_by_rel

      def find_by_rel!(rel)
        record = self.find_by_rel(rel)

        raise OpenAi::Errors::LinkNotFoundError.new("Could not find link with rel `%s`" % [rel]) if record.nil?

        record
      end
      alias route_for! find_by_rel!

      private
      def internal_collection
        @collection.map { |record| OpenAi::Models::Link.new(record) }
      end
    end
  end
end
