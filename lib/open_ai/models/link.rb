require 'addressable'

module OpenAi
  module Models
    class Link
      include Comparable

      def initialize(attributes={})
        @attributes = attributes
      end

      def name
        @attributes['name']
      end

      def path
        @attributes['path']
      end

      def rel
        @attributes['rel']
      end

      def templated
        @attributes.fetch('templated', false)
      end
      alias :templated? :templated

      # Returns the fully qualified URL
      #
      # @return [String]
      def url_for(options={})
        if self.templated?
          template = Addressable::Template.new(self.path)
          template = template.expand(options)
          template.to_s
        else
          self.path
        end
      end
    end
  end
end
