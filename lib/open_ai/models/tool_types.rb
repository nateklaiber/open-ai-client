module OpenAi
  module Models
    class ToolTypes
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def self.list(params={})
        request = OpenAi::Requests::ToolTypes.list(params)

        return self.new(request)
      end

      def self.retrieve(id, params={})
        request = OpenAi::Requests::ToolTypes.retrieve(id, params)

        if !request.nil?
          return OpenAi::Models::ToolType.new(request)
        else
          return nil
        end
      end

      def self.discontinued
        records = self.list
        records.discontinued
      end

      def each(&block)
        internal_collection.each(&block)
      end

      def discontinued_attributes
        self.select(&:is_discontinued).map(&:to_attributes)
      end

      def discontinued
        self.class.new(self.discontinued_attributes)
      end

      private
      def internal_collection
        @collection.map { |record| OpenAi::Models::ToolType.new(record) }
      end
    end
  end
end
