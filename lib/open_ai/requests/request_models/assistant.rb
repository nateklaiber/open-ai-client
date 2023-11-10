  module OpenAi
    module Requests
      module RequestModels
        class Assistant
          def initialize(attributes={})
            @attributes = Hash(attributes)
          end

          def self.from_original_attributes(attributes={})
            record_attributes = Hash(attributes)

            params = {
              :id         => record_attributes['id'],
              :object => record_attributes['object'],
              :created_at  => record_attributes['created_at'],
              :name   => record_attributes['name'],
              :description   => record_attributes['description'],
              :model_id => record_attributes['model'],
              :instructions  => record_attributes['instructions'],
              :tools         => OpenAi::Requests::RequestModels::Tools.new(record_attributes['tools']).as_original_attributes,
              :file_ids      => record_attributes['file_ids'],
              :metadata      => record_attributes['medatada']
            }
          end

          def self.from_original(attributes={})
            klass = self.new(self.from_original_attributes(attributes))
            klass
          end

          def model_id
            @attributes[:model_id]
          end

          def name
            @attributes[:name]
          end

          def description
            @attributes[:description]
          end

          def instructions
            @attributes[:instructions]
          end

          def tools
            @attributes[:tools]
          end

          def tools_attributes
            Array(@attributes.fetch(:tools, []))
          end

          def tools
            OpenAi::Requests::RequestModels::Tools.new(self.tools_attributes)
          end

          def file_ids
            @attributes[:file_ids]
          end

          def metadata
            @attributes[:metadata]
          end

          def as_original_attributes
            attrs = {
              :model => self.model_id,
              :name => self.name,
              :description => self.description,
              :instructions => self.instructions,
              :tools        => self.tools.as_original_attributes
            }
            attrs
          end

          def as_json(*)
            self.as_original_attributes
          end

          def to_attributes
            @attributes
          end
        end
      end
    end
  end
