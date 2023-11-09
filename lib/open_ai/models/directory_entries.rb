module OpenAi
  module Models
    class DirectoryEntries
      include Enumerable

      def initialize(collection)
        @collection = Array(collection)
      end

      def each(&block)
        internal_collection.each(&block)
      end

      def to_restless_router
        routes = RestlessRouter::Routes.new

        self.each do |record|
          routes.add_route(record)
        end

        routes
      end

      private
      def internal_collection
        @collection.map { |record| OpenAi::Models::DirectoryEntry.new(record) }
      end
    end
  end
end
