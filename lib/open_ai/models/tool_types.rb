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

      def each(&block)
        internal_collection.each(&block)
      end

      def to_options
        self.map(&:to_option)
      end

      def to_attributes
        Array(self.map(&:to_attributes)).flatten
      end

      private
      def internal_collection
        @collection.map { |record| OpenAi::Models::ToolType.new(record) }
      end
    end
  end
end
