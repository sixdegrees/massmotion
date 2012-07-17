require 'faraday'
require 'massmotion/request/auth'
require 'faraday_middleware/response/parse_json'
require 'faraday_middleware/response/caching'

module Massmotion
  module Connection
  private

    # Returns a Faraday::Connection object
    #
    # @param options [Hash] A hash of options
    # @return [Faraday::Connection]
    def connection(options={})
      default_options = {
        :headers => {
          :accept => 'application/json',
          :user_agent => user_agent,
          :content_type => 'application/json'
        },
        :ssl => {:verify => false},
        :url => options.fetch(:endpoint, endpoint),
        :timeout => 10,
        :open_timeout => 10
      }
      @connection ||= Faraday.new(default_options.deep_merge(connection_options)) do |builder|
        builder.use Massmotion::Request::Auth, credentials
        # builder.use Faraday::Request::UrlEncoded
        builder.use FaradayMiddleware::Caching, cache_store unless cache_store.nil?
        builder.use FaradayMiddleware::ParseJson
        # builder.use FaradayMiddleware::Mashify
        builder.adapter(adapter)
      end
    end
  end
end
