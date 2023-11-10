  module OpenAi
    module Requests
      module RequestModels
        class ChatCompletion
          def initialize(attributes={})
            @attributes = Hash(attributes)
          end

          def self.from_original_attributes(attributes={})
            record_attributes = Hash(attributes)

            params = {
              :model_id      => record_attributes['model'],
              :messages => OpenAi::Requests::RequestModels::ChatMessages.new(record_attributes['messages']).as_original_attributes,
              :metadata      => record_attributes['medatada']
            }
          end

          def self.from_original(attributes={})
            klass = self.new(self.from_original_attributes(attributes))
            klass
          end

          def user
            @attributes[:user]
          end

          def temperature
            @attributes[:temperature]
          end

          def response_format
            @attributes[:response_format]
          end

          def model_id
            @attributes[:model_id]
          end

          def messages_attributes
            Array(@attributes.fetch(:messages, []))
          end

          def messages
            OpenAi::Requests::RequestModels::ChatMessages.new(self.messages_attributes)
          end

          def file_ids
            @attributes[:file_ids]
          end

          def metadata
            @attributes[:metadata]
          end

          def as_original_attributes
            attrs = {
              :model       => self.model_id,
              :temperature => self.temperature,
              :messages    => self.messages.as_original_attributes
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
