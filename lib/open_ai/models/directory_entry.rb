module OpenAi
  module Models
    class DirectoryEntry < SimpleDelegator
      include Comparable

      def initialize(attributes={})
        @attributes = Hash(attributes)

        @_record = RestlessRouter::Route.new(@attributes['rel'], @attributes['path'], templated: @attributes['templated'])
      end

      def __getobj__
        @_record
      end

      def href_value
        [OpenAi::Client.api_host, self.path].join('/')
      end

      def to_attributes
        @attributes
      end
    end
  end
end
