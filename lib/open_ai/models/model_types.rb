module OpenAi
  module Models
    class ModelTypes
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def self.list(params={})
        request = OpenAi::Requests::ModelTypes.list(params)

        return self.new(request)
      end

      def self.retrieve(id, params={})
        request = OpenAi::Requests::ModelTypes.retrieve(id, params)

        if !request.nil?
          return OpenAi::Models::ModelType.new(request)
        else
          return OpenAi::Models::NullModelType.new(request)
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
        @collection.map { |record| OpenAi::Models::ModelType.new(record) }
      end
    end
  end
end
