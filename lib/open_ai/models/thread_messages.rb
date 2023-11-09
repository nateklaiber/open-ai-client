module OpenAi
  module Models
    class ThreadMessages
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def self.list_by_thread_id(thread_id, params={})
        request = OpenAi::Requests::ThreadMessages.list_by_thread_id(thread_id, params)

        request.on(:success) do |resp|
          data_attributes = resp.data_attributes

          self.new(data_attributes)
        end
      end

      def self.retrieve_by_thread_id(thread_id, id, params={})
        request = OpenAi::Requests::ThreadMessages.retrieve_by_thread_id(thread_id, id, params)

        request.on(:success) do |resp|
          response_body = resp.body

          return OpenAi::Models::ThreadMessage.new(response_body)
        end
      end

      def each(&block)
        internal_collection.each(&block)
      end

      private
      def internal_collection
        @collection.map { |record| OpenAi::Models::ThreadMessage.new(record) }
      end
    end
  end
end
