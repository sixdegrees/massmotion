require 'digest/md5'

module Massmotion
  module Request
    class Auth  < Faraday::Middleware

      def call(env)
        env[:request_headers]['mmm-api-key'] = @credentials[:api_key]
        @app.call(env)
      end

      def initialize(app, credentials)
        @app, @credentials = app, credentials
      end

    end
  end
end