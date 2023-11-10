module OpenAi
  module Models
    class RateLimit
      extend Forwardable

      def_delegator :rate_limit_type, :description
      def_delegator :rate_limit_type, :unit_value
      def_delegator :rate_limit_type, :unit_type

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def type_value
        @attributes['type']
      end
      alias id type_value

      def rate_limit_type
        @rate_limit_type ||= OpenAi::Models::RateLimitTypes.retrieve(self.id)
      end

      def value
        @attributes['value']
      end

      def unit_object
        case(self.unit_type)
        when('each')
          RubyUnits::Unit.new(("%s %s" % [self.value, self.unit_value]))
        when('time')
          time_mapping = {
            'm'  => 'minute',
            'ms' => 'millisecond',
            'h'  => 'hour',
            's'  => 'second',
          }
          parts = self.value.to_s.scan(/(([\d]+)([h|m|ms]+))/).to_a

          units = parts.map do |part|
            part_value = ("%s %s" % [part[1], time_mapping[part[2]]])
            RubyUnits::Unit.new(part_value)
          end

          units.sum.convert_to('millisecond')
        end
      end

      def to_attributes
        @attributes
      end
    end
  end
end
