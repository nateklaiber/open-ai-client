module OpenAi
  module Models
    class RoleTypes
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def self.list(params={})
        request = OpenAi::Requests::RoleTypes.list(params)

        return self.new(request)
      end

      def self.retrieve(id, params={})
        request = OpenAi::Requests::RoleTypes.retrieve(id, params)

        if !request.nil?
          return OpenAi::Models::RoleType.new(request)
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

      private
      def internal_collection
        @collection.map { |record| OpenAi::Models::RoleType.new(record) }
      end
    end
  end
end
