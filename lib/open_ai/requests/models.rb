module OpenAi
  module Requests
    class Models
      def self.list(params={})
        directory = OpenAi::Models::Directory.retrieve

        default_params = {
          :version => directory.version
        }

        request_params = default_params.merge!(params)

        route = directory.links.to_restless_router.route_for('models')
        url   = route.url_for(request_params)

        request = OpenAi::Client.connection.get do |req|
          if block_given?
            if block.arity == 1
              yield(req)
              req.url(url)
            else
              req.instance_eval(&block)
              req.url(url)
            end
          else
            req.url(url)
          end
        end

        OpenAi::Response.new(request)
      end

      def self.retrieve(id, params={})
        directory = OpenAi::Models::Directory.retrieve

        default_params = {
          :version => directory.version
        }

        request_params = default_params.merge!(params)

        route = directory.links.to_restless_router.route_for('model')
        url   = route.url_for(request_params.merge!(id: id))

        request = OpenAi::Client.connection.get do |req|
          if block_given?
            if block.arity == 1
              yield(req)
              req.url(url)
            else
              req.instance_eval(&block)
              req.url(url)
            end
          else
            req.url(url)
          end
        end

        OpenAi::Response.new(request)
      end
    end
  end
end
