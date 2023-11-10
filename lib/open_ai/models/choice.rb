module OpenAi
  module Models
    class Choice
      extend Forwardable

      include Comparable

      def_delegator :message, :role
      def_delegator :message, :content

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def <=>(other)
        self.index <=> other.index
      end

      def index
        @attributes['index']
      end

      def message_attributes
        Hash(@attributes.fetch('message', {}))
      end

      def message
        OpenAi::Models::ChatMessage.new(self.message_attributes)
      end

      def finish_reason
        @attributes['finish_reason']
      end

      def to_attributes
        @attributes
      end
    end
  end
end
