require File.expand_path('../utilities/status_code_mapper', __FILE__)
require 'faraday_middleware'
require 'delegate'

module OpenAi
  class Response < SimpleDelegator
    STATUS_MAP = {
      :failure      => (400...500),
      :redirect     => (300...400),
      :success      => (200...300),
      :server_error => (500...600)
    }

    def initialize(response)
      @_response = response
    end

    def allowed?(method)
      self.allowed_methods.include?(method.upcase)
    end

    def on(*statuses, &block)
      status_code_mapper = OpenAi::Utilities::StatusCodeMapper.new(statuses)

      return unless status_code_mapper.includes?(@_response.status)

      if block_given?
        yield(self)
      else
        self
      end
    end

    def redirect?
      STATUS_MAP[:redirect].include?(self.status)
    end

    def failure?
      STATUS_MAP[:failure].include?(self.status)
    end

    def server_error?
      STATUS_MAP[:server_error].include?(self.status)
    end

    def __getobj__
      @_response
    end

    def request_id
      self.headers['x-request-id']
    end

    def openai_organization_id
      self.headers['openai-organization']
    end

    def openai_model
      self.headers['openai-model']
    end

    def openai_version
      self.headers['openai-version']
    end

    def processing_time
      self.headers['openai-processing-ms']
    end

    def processing_time_unit_object
      RubyUnits::Unit.new(("%s %s" % [self.processing_time, 'millisecond']))
    end

    def allow_header
      self.headers.fetch('allow', '')
    end

    def json?
      self.body.is_a?(Hash)
    end

    def data_attributes
      if self.json?
        self.body['data']
      end
    end

    def data_attributes?
      !self.data.nil?
    end

    def rate_limit_attributes
      records = []

      Hash(self.headers).slice(*OpenAi::Models::RateLimitTypes.header_keys).inject(records) do |coll,(k,v)|
        record_attributes = {
          'type'  => k,
          'value' => v
        }
        coll.push(record_attributes)
        coll
      end

      records
    end

    def rate_limit_attributes?
      !self.rate_limit_attributes.empty?
    end

    def rate_limits
      if self.rate_limit_attributes?
        OpenAi::Models::RateLimits.new(self.rate_limit_attributes)
      else
        OpenAi::Models::RateLimits.none
      end
    end

    def rate_limits?
      self.rate_limits.any?
    end

    def allowed_methods
      self.allow_header.split(',').map(&:strip).map(&:upcase)
    end
  end
end
