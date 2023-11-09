module OpenAi
  module Models
    class NullModelType
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def name
        'Unknown'
      end

      def model_id
        nil
      end

      def model
        @model ||= OpenAi::Models::Models.retrieve(self.model_id)
      end

      def description
        'Unknown'
      end

      def tokens_count
        0
      end

      def training_data_recent_date_value
        nil
      end

      def training_data_recent_date
        begin
          Date.parse(self.training_data_recent_date_value)
        rescue
          nil
        end
      end

      def discontinued_date_value
        nil
      end

      def discontinued_date
        begin
          Date.parse(self.discontinued_date_value)
        rescue
          nil
        end
      end

      def discontinued_date?
        !self.discontinued_date.nil?
      end

      def is_discontinued
        self.discontinued_date?
      end

      def replacement_model_id
        nil
      end

      def replacement_model
        @replacement_model ||= OpenAi::Models::Models.retrieve(self.replacement_model_id)
      end

      def replacement_model?
        !self.replacement_model.nil?
      end

      def to_attributes
        @attributes
      end
    end
  end
end
