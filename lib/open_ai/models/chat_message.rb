module OpenAi
  module Models
    class ChatMessage
      include Comparable

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def role
        @attributes['role']
      end

      def content
        @attributes['content']
      end

      def to_attributes
        @attributes
      end
    end
  end
end
