module OpenAi
  module Models
    class ChatCompletion
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def self.create(record_attributes={}, params={})
        OpenAi::Models::ChatCompletions.create(record_attributes, params)
      end

      def id
        @attributes['id']
      end

      def object
        @attributes['object']
      end

      def system_fingerprint
        @attributes['system_fingerprint']
      end

      def model_id
        @attributes['model']
      end

      def model
        @model ||= OpenAi::Models::Models.retrieve(self.model_id)
      end

      def model?
        !self.model.nil?
      end

      def created_at_timestamp
        @attributes['created']
      end

      def created_at
        begin
          Time.at(self.created_at_timestamp)
        rescue
          nil
        end
      end

      def choices_attributes
        Array(@attributes.fetch('choices', []))
      end

      def choices
        OpenAi::Models::Choices.new(self.choices_attributes)
      end

      def choices?
        self.choices.any?
      end

      def usage_attributes
        Hash(@attributes.fetch('usage', {}))
      end

      def usage
        @usage||= OpenAi::Models::Usage.new(self.usage_attributes)
      end

      def to_attributes
        @attributes
      end
    end
  end
end
