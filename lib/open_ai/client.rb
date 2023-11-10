require 'dotenv'
Dotenv.load

require 'delegate'
require 'chronic'
require 'ruby-units'
require 'logger'
require 'date'
require 'liquid'
require 'multi_json'
require 'addressable'
require 'restless_router'
require 'open_ai/client/version'

require 'open_ai/errors'
require 'open_ai/logger'
require 'open_ai/configuration'
require 'open_ai/connection'
require 'open_ai/response'

require 'open_ai/utilities'

require "open_ai/requests"
require "open_ai/models"

module OpenAi
  module Client
    # Class accessor methods to be utilized
    # throughout the gem itself.
    class << self
      attr_accessor :configuration
      attr_accessor :routes
    end

    # Create a default Configuration to use
    # throughout the gem
    #
    # @return [OpenAi::Configuration] Configuration object utilizing the Default
    def self.configuration
      @configuration ||= OpenAi::Configuration.new
    end

    # Specify configuration options. This will be applied to
    # our memoized Configuration.
    #
    # @return [OpenAi::Configuration]
    def self.configure
      yield(self.configuration)
    end

    # Helper method to access the Connection object
    #
    # @return [OpenAi::Connection] Faraday Response Delegator
    def self.connection
      @connection ||= OpenAi::Connection.new(url: self.configuration.api_host) do |builder|
        builder.response(:json, content_type: /\bjson/)

        builder.response(:logger, self.configuration.request_logger)

        builder.adapter(OpenAi::Connection.default_adapter)
      end

      # Inject Authorization
      @connection.headers['Authorization'] = ("Bearer %s" % [self.configuration.access_token])

      # Merge default headers
      @connection.headers.merge!(self.configuration.connection_options[:headers])
      @connection.headers.merge!('OpenAI-Beta' => 'assistants=v1')

      @connection
    end

    # Takes in a user access token and returns a user session
    #
    # @param access_token [String]
    #
    # @return [noop]
    def self.with_access_token(access_token, &block)
      begin
        configuration = self.configure do |c|
          c.access_token = access_token
        end

        yield(block) if block_given?
      rescue OpenAi::Errors::InvalidAuthenticationError => e
        raise StandardError.new(e.message)
      rescue => e
        raise StandardError.new(e.inspect)
      end
    end

    # Helper method to peform a GET request
    #
    # @return [OpenAi::Response] Faraday Response Delegator
    def self.get(url, data={}, headers={})
      request = self.connection.get(url, data, headers)

      OpenAi::Response.new(request)
    end

    # Helper method to perform a HEAD request
    #
    # @return [OpenAi::Response] Faraday Response Delegator
    def self.head(url, data={}, headers={})
      request = self.connection.head(url, data, headers)

      OpenAi::Response.new(request)
    end

    # Helper method to perform a OPTIONS request
    #
    # @return [OpenAi::Response] Faraday Response Delegator
    def self.options(url, headers={})
      request = self.connection.http_options(url, nil, headers)

      OpenAi::Response.new(request)
    end

    # Helper method to perform a PUT request
    #
    # @return [OpenAi::Response] Faraday Response Delegator
    def self.put(url, data={}, headers={})
      request = self.connection.put(url, data, headers)

      OpenAi::Response.new(request)
    end

    # Helper method to perform a POST request
    #
    # @return [OpenAi::Response] Faraday Response Delegator
    def self.post(url, data={}, headers={})
      request = self.connection.post(url, data, headers)

      OpenAi::Response.new(request)
    end

    def self.delete(url, data={}, headers={})
      request = self.connection.delete(url, data, headers)

      OpenAi::Response.new(request)
    end

    def self.logger
      self.configuration.logger
    end

    # Returns the root directory response
    #
    # @return [OpenAi::Models::Directory]
    def self.directory
      @directory ||= OpenAi::Models::Directory.retrieve
    end

    # Define the API routes
    #
    # These are the endpoints that will be used to interact
    # with the API. Before you make any requests you will
    # want to add the corresponding routes here.
    #
    # @return [RestlessRouter::Routes] A collection of Routes
    def self.routes
      return @routes if @routes

      @routes = self.directory.links

      @routes
    end

    # Returns the link relationship for
    # a specified path.
    #
    # Custom link relationships are fully qualified
    # URIS, but in this case we only care to reference
    # the path and add the API host.
    #
    # @return [String]
    def self.rel_for(rel)
      "%s/rels/%s" % [self.api_host, rel]
    end

    # Helper method to return the API HOST
    #
    # @return [String] API URI
    def self.api_host
      self.configuration.api_host
    end
  end
end
