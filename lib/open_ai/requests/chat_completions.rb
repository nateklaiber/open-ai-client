module OpenAi
  module Requests
    class ChatCompletions

      def self.create(request_model_params={}, params={})
        directory = OpenAi::Models::Directory.retrieve

        request_model = OpenAi::Requests::RequestModels::ChatCompletion.new(request_model_params)

        default_params = {
          :version => directory.version
        }

        request_params = default_params.merge!(params)

        route = directory.links.to_restless_router.route_for('chat-completions')
        url   = route.url_for(request_params)

        request = OpenAi::Client.connection.post do |req|
          if block_given?
            if block.arity == 1
              yield(req)
              req.url(url)
            else
              req.instance_eval(&block)
              req.url(url)
            end
          else
            req.headers['Content-Type'] = 'application/json'
            req.body = MultiJson.dump(request_model.as_json)
            req.url(url)
          end
        end

        OpenAi::Response.new(request)
      end
    end
  end
end
