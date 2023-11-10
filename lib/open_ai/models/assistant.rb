module OpenAi
  module Models
    class Assistant
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def self.list(params={})
        OpenAi::Models::Assistants.list(params)
      end

      def self.retrieve(id, params={})
        OpenAi::Models::Assistants.retrieve(id, params)
      end

      def self.create(record_attributes={}, params={})
        OpenAi::Models::Assistants.create(record_attributes, params)
      end

      def id
        @attributes['id']
      end

      def update(record_attributes={})
        request_model     = OpenAi::Requests::RequestModels::Assistant.from_original(self.to_attributes)
        record_attributes = request_model.to_attributes.merge!(record_attributes)

        OpenAi::Models::Assistants.update(self.id, record_attributes)
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

      def created_at
        begin
          Time.at(self.created_at_timestamp)
        rescue
          nil
        end
      end

      def tools_attributes
        Array(@attributes.fetch('tools', []))
      end
      alias tool_types_attributes tools_attributes

      def tools
        OpenAi::Models::ToolTypes.new(self.tools_attributes)
      end
      alias tool_types tools

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

      def to_option
        [self.name, self.id]
      end

      def to_attributes
        @attributes
      end
    end
  end
end
