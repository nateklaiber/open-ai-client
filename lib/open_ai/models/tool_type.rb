module OpenAi
  module Models
    class ToolType
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def type
        @attributes['type']
      end
      alias id type

      def name
        @attributes['name']
      end

      def to_option
        [self.name, self.id]
      end

      def to_attributes
        @attributes
      end
    end
  end
end
