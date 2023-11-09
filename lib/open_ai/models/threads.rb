module OpenAi
  module Models
    class Threads
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def self.list(params={})
        request = OpenAi::Requests::Threads.list(params)

        request.on(:success) do |resp|
          data_attributes = resp.data_attributes

          self.new(data_attributes)
        end
      end

      def self.retrieve(id, params={})
        request = OpenAi::Requests::Threads.retrieve(id, params)

        request.on(:success) do |resp|
          response_body = resp.body

          return OpenAi::Models::Thread.new(response_body)
        end
      end

      def each(&block)
        internal_collection.each(&block)
      end

      private
      def internal_collection
        @collection.map { |record| OpenAi::Models::Thread.new(record) }
      end
    end
  end
end
