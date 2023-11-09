module OpenAi
  module Models
    class Assistants
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def self.list(params={})
        request = OpenAi::Requests::Assistants.list(params)

        request.on(:success) do |resp|
          data_attributes = resp.data_attributes

          self.new(data_attributes)
        end
      end

      def self.retrieve(id, params={})
        request = OpenAi::Requests::Assistants.retrieve(id, params)

        request.on(:success) do |resp|
          response_body = resp.body

          return OpenAi::Models::Assistant.new(response_body)
        end
      end

      def each(&block)
        internal_collection.each(&block)
      end

      private
      def internal_collection
        @collection.map { |record| OpenAi::Models::Assistant.new(record) }
      end
    end
  end
end
