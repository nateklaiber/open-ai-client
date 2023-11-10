module OpenAi
  module Models
    class ChatCompletions
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def self.create(record_attributes={}, params={})
        request = OpenAi::Requests::ChatCompletions.create(record_attributes, params)

        request.on(:success) do |resp|
          response_body = resp.body

          return OpenAi::Models::ChatCompletion.new(response_body)
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
        @collection.map { |record| OpenAi::Models::ChatCompletion.new(record) }
      end
    end
  end
end
