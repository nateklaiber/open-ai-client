module OpenAi
  module Models
    class ThreadRun
      include Comparable

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def <=>(other)
        self.started_at <=> other.started_at
      end

      def id
        @attributes['id']
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

      def model_id
        @attributes['model']
      end

      def assistant_id
        @attributes['assistant_id']
      end

      def thread_id
        @attributes['thread_id']
      end

      def status_value
        @attributes['status']
      end

      def started_at_timestamp
        @attributes['started_at']
      end

      def started_at
        begin
          Time.at(self.started_at_timestamp)
        rescue
          nil
        end
      end

      def expires_at_timestamp
        @attributes['expires_at']
      end

      def expires_at
        begin
          Time.at(self.expires_at_timestamp)
        rescue
          nil
        end
      end

      def cancelled_at_timestamp
        @attributes['cancelled_at']
      end

      def cancelled_at
        begin
          Time.at(self.cancelled_at_timestamp)
        rescue
          nil
        end
      end

      def failed_at_timestamp
        @attributes['failed_at']
      end

      def failed_at
        begin
          Time.at(self.failed_at_timestamp)
        rescue
          nil
        end
      end

      def completed_at_timestamp
        @attributes['completed_at']
      end

      def completed_at
        begin
          Time.at(self.completed_at_timestamp)
        rescue
          nil
        end
      end

      def instructions
        @attributes['instructions']
      end

      def tools_attributes
        Array(@attributes.fetch('tools', []))
      end

      def file_ids
        Array(@attributes.fetch('file_ids', []))
      end

      def metadata_attributes
        Hash(@attributes.fetch('metadata', {}))
      end

      def to_attributes
        @attributes
      end
    end
  end
end
