module OpenAi
  module Requests
    class ModelTypes

      def self.list(params={}, &block)
        file_path = File.expand_path('../../../../data/model_types.json', __FILE__)
        file_contents = File.read(file_path)

        return MultiJson.load(file_contents)
      end

      def self.retrieve(id, params={}, &block)
        file_path = File.expand_path('../../../../data/model_types.json', __FILE__)
        file_contents = File.read(file_path)

        records =  MultiJson.load(file_contents)
        records.find { |record| record['model_id'] == id }
      end
    end
  end
end
