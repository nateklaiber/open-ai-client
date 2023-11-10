module OpenAi
  module Requests
    module RequestModels
      class ChatMessages
        include Enumerable

        def initialize(collection=[])
          @collection = Array(collection)
        end

        def each(&block)
          internal_collection.each(&block)
        end

        def as_original_attributes
          Array(self.map(&:as_original_attributes))
        end

        private
        def internal_collection
          @collection.map { |record| OpenAi::Requests::RequestModels::ChatMessage.new(record) }
        end
      end
    end
  end
end
