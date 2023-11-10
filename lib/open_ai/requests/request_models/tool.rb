  module OpenAi
    module Requests
      module RequestModels
        class Tool
          def initialize(attributes={})
            @attributes = Hash(attributes)
          end

          def self.from_original_attributes(attributes={})
            record_attributes = Hash(attributes)

            params = {
              :type         => record_attributes['type'],
            }
          end

          def self.from_original(attributes={})
            klass = self.new(self.from_original_attributes(attributes))
            klass
          end

          def type
            @attributes[:type]
          end

          def as_original_attributes
            attrs = {
              :type => self.type,
            }
            attrs
          end

          def as_json(*)
            self.as_original_attributes
          end
        end
      end
    end
  end
