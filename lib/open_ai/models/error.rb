module OpenAi
  module Models
    class Error
      extend Forwardable

      def_delegator :error_item, :message
      def_delegator :error_item, :type
      def_delegator :error_item, :param
      def_delegator :error_item, :code

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def error_item_attributes
        Hash(@attributes.fetch('error', {}))
      end

      def error_item
        OpenAi::Models::ErrorItem.new(self.error_item_attributes)
      end

      def to_attributes
        @attributes
      end
    end
  end
end
