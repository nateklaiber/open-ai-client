module OpenAi
  module Models
    class Thread
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def messages(params={})
        OpenAi::Models::ThreadMessages.list_by_thread_id(self.id, params)
      end

      def messages?(params={})
        self.messages(params).any?
      end

      def runs(params={})
        OpenAi::Models::ThreadRuns.list_by_thread_id(self.id, params)
      end

      def runs?(params={})
        self.runs(params).any?
      end

      def object
        @attributes['object']
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
