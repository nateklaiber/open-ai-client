module OpenAi
  module Models
    class Assistant
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def object
        @attributes['object']
      end

      def name
        @attributes['name']
      end

      def description
        @attributes['description']
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

      # @note: We want to parse this as a schema
      def instructions
        @attributes['instructions']
      end

      def created_at_timestamp
        @attributes['created_at']
      end

      def tools_attributes
        Array(@attributes.fetch('tools', []))
      end

      def tools
        # List
      end

      def tools?
        self.tools.any?
      end

      def file_ids
        Aray(@attributes.fetch('file_ids', []))
      end

      def files
        # List
      end

      def files?
        self.files.any?
      end

      def metadata_attributes
        @attributes['metadata']
      end

      def metadata
        # Retrieve
      end

      def to_attributes
        @attributes
      end
    end
  end
end
