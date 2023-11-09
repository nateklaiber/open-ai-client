module OpenAi
  module Requests
    class Directory

      def self.retrieve(params={}, &block)
        file_path = File.expand_path('../../../../data/routes.json', __FILE__)
        file_contents = File.read(file_path)

        return MultiJson.load(file_contents)
      end
    end
  end
end
