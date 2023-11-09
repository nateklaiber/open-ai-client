module OpenAi
  module Models
    class ModelType
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def name
        @attributes['name']
      end

      def model_id
        @attributes['model_id']
      end

      def model
        @model ||= OpenAi::Models::Models.retrieve(self.model_id)
      end

      def description
        @attributes['description']
      end

      def tokens_count
        @attributes['tokens_count']
      end

      def training_data_recent_date_value
        @attributes['training_data_recent_date']
      end

      def training_data_recent_date
        begin
          Date.parse(self.training_data_recent_date_value)
        rescue
          nil
        end
      end

      def discontinued_date_value
        @attributes['discontinued_date']
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
        (self.discontinued_date? && (self.discontinued_date < Date.today))
      end

      def replacement_model_id
        @attributes['replacement_model_id']
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
