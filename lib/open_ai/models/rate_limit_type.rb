module OpenAi
  module Models
    class RateLimitType
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def type
        @attributes['type']
      end
      alias id type

      def description
        @attributes['description']
      end

      def unit_type
        @attributes['unit_type']
      end

      def unit_value
        @attributes['unit_value']
      end

      def to_header_key
        self.type
      end

      def to_attributes
        @attributes
      end
    end
  end
end
