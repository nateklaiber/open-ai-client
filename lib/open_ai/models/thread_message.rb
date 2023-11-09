module OpenAi
  module Models
    class ThreadMessage
      include Comparable

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def <=>(other)
        self.created_at <=> other.created_at
      end

      def id
        @attributes['id']
      end

      def run_id
        @attributes['run_id']
      end

      def run_attributes
        Hash(@attributes.fetch('run', {}))
      end

      def run_attributes?
        !self.run_attributes.empty?
      end

      def run
        return @run if @run

        run = if self.run_attributes?
                OpenAi::Models::ThreadRun.new(self.run_attributes)
              else
                OpenAi::Models::ThreadRuns.retrieve_by_thread_id(self.thread_id, self.run_id)
              end

        @run = run
      end

      def assistant_id
        @attributes['assistant_id']
      end

      def assistant_attributes
        Hash(@attributes.fetch('assistant', {}))
      end

      def assistant_attributes?
        !self.assistant_atributes.empty?
      end

      def assistant
        return @assistant if @assistant

        assistant = if self.assistant_attributes?
                      OpenAi::Models::Assistant.new(self.assistant_attributes)
                    else
                      OpenAi::Models::Assistants.retrieve(self.assistant_id)
                    end

        @assistant = assistant
      end

      def assistant?
        !self.assistant.nil?
      end

      def thread_id
        @attributes['thread_id']
      end

      def thread_attributes
        Hash(@attributes.fetch('thread', {}))
      end

      def thread_attributes?
        !self.thread_attributes.empty?
      end

      def thread
        return @thread if @thread

        thread = if self.thread_attributes?
                   OpenAi::Models::Thread.new(self.thread_attributes)
                 else
                   OpenAi::Models::Threads.retrieve(self.thread_id)
                 end

        @thread = thread
      end

      def thread?
        !self.thread.nil?
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

      def role_value
        @attributes['role']
      end

      def contents_attributes
        Array(@attributes.fetch('content', []))
      end

      def contents
        @contents ||= OpenAi::Models::Contents.new(self.contents_attributes)
      end

      def contents?
        self.contents.any?
      end

      def metadata_attributes
        @attributes['metadata']
      end

      def metadata
        # Retrieve
      end

      def file_ids
        Array(@attributes.fetch('file_ids', []))
      end

      def to_attributes
        @attributes
      end
    end
  end
end
