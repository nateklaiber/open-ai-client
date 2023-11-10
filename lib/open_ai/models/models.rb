module OpenAi
  module Models
    class Models
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def self.list(params={})
        request = OpenAi::Requests::Models.list(params)

        request.on(:success) do |resp|
          data_attributes = resp.data_attributes

          self.new(data_attributes)
        end
      end

      def self.retrieve(id, params={})
        request = OpenAi::Requests::Models.retrieve(id, params)

        request.on(:success) do |resp|
          response_body = resp.body

          return OpenAi::Models::Model.new(response_body)
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

      def to_options
        self.map(&:to_option)
      end

      def to_attributes
        Array(self.map(&:to_attributes)).flatten
      end

      private
      def internal_collection
        @collection.map { |record| OpenAi::Models::Model.new(record) }
      end
    end
  end
end
