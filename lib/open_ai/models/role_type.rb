module OpenAi
  module Models
    class RoleType
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

      def description
        @attributes['description']
      end

      def to_attributes
        @attributes
      end
    end
  end
end
