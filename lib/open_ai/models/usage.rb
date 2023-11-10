module OpenAi
  module Models
    class Usage

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def prompt_tokens
        @attributes['prompt_tokens']
      end

      def completion_tokens
        @attributes['completion_tokens']
      end

      def total_tokens
        @attributes['total_tokens']
      end

      def to_attributes
        @attributes
      end
    end
  end
end
