module OpenAi
  module Models
    class ErrorItem

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def message
        @attributes['message']
      end

      def type
        @attributes['type']
      end

      def param
        @attributes['param']
      end

      def code
        @attributes['code']
      end

      def to_attributes
        @attributes
      end
    end
  end
end
