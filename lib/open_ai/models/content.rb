module OpenAi
  module Models
    class Content
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def type_value
        @attributes['type']
      end

      def text_attributes
        Hash(@attributes.fetch('text', {}))
      end

      def to_attributes
        @attributes
      end
    end
  end
end
