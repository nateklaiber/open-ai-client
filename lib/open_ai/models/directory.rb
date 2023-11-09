module OpenAi
  module Models
    class Directory
      def initialize(attributes={})
        @attributes = attributes
      end

      def self.retrieve(params={})
        request = OpenAi::Requests::Directory.retrieve(params)

        return self.new(request)
      end

      def title
        @attributes['title']
      end

      def description
        @attributes['description']
      end

      def version
        @attributes['version']
      end

      def links_attributes
        @attributes.fetch('links', [])
      end

      def links
        @links ||= OpenAi::Models::DirectoryEntries.new(self.links_attributes)
      end

      def links?
        self.links.any?
      end
    end
  end
end
