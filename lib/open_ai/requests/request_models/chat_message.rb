  module OpenAi
    module Requests
      module RequestModels
        class ChatMessage
          def initialize(attributes={})
            @attributes = Hash(attributes)
          end

          def self.from_original_attributes(attributes={})
            record_attributes = Hash(attributes)

            params = {
              :role    => record_attributes['role'],
              :content => record_attributes['content'],
            }
          end

          def self.from_original(attributes={})
            klass = self.new(self.from_original_attributes(attributes))
            klass
          end

          def role
            @attributes[:role]
          end

          def content
            @attributes[:content]
          end

          def as_original_attributes
            attrs = {
              :role    => self.role,
              :content => self.content,
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
