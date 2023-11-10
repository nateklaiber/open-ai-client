module OpenAi
  module Models
    class Model
      include Comparable

      extend Forwardable

      def_delegator :model_type, :name
      def_delegator :model_type, :description
      def_delegator :model_type, :tokens_count
      def_delegator :model_type, :discontinued_date
      def_delegator :model_type, :discontinued_date?
      def_delegator :model_type, :is_discontinued
      def_delegator :model_type, :replacement_model
      def_delegator :model_type, :replacement_model?

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def <=>(other)
        self.id <=> other.id
      end

      def id
        @attributes['id']
      end

      def model_type
        @model_type ||= OpenAi::Models::ModelTypes.retrieve(self.id)
      end

      def model_type?
        !self.model_type.nil?
      end

      def object
        @attributes['object']
      end

      def created_at_timestamp
        @attributes['created']
      end

      def created_at
        begin
          Time.at(self.created_at_timestamp)
        rescue
          nil
        end
      end

      def owned_by
        @attributes['owned_by']
      end

      def to_option
        [self.id, self.id]
      end

      def to_attributes
        @attributes
      end
    end
  end
end
