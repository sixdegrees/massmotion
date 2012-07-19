require 'massmotion/version'

module Massmotion
  # Defines constants and methods related to configuration
  module Config

    # The HTTP connection adapter that will be used to connect if none is set
    DEFAULT_ADAPTER = :net_http

    # The Faraday connection options if none is set
    DEFAULT_CONNECTION_OPTIONS = {}

    # The endpoint that will be used to connect if none is set
    #
    DEFAULT_ENDPOINT            = 'http://bovideo.massmotionmedia.com'

    DEFAULT_CACHE_STORE = nil
    
    # The value sent in the 'User-Agent' header if none is set
    DEFAULT_USER_AGENT = "Massmotion Ruby Gem #{Massmotion::VERSION}"

    # An array of valid keys in the options hash when configuring a {Massmotion::Client}
    VALID_OPTIONS_KEYS = [
      :adapter,
      :api_key,
      :notification_callback,
      :connection_options,
      :endpoint,
      :user_agent,
      :cache_store
    ]

    attr_accessor *VALID_OPTIONS_KEYS

    def domain
      @domain ||= URI.parse(endpoint).host unless endpoint.nil?
    end

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end

    # Reset all configuration options to defaults
    def reset
      @domain                     = nil
      self.adapter                = DEFAULT_ADAPTER
      self.connection_options     = DEFAULT_CONNECTION_OPTIONS
      self.endpoint               = DEFAULT_ENDPOINT
      self.user_agent             = DEFAULT_USER_AGENT
      self.cache_store            = DEFAULT_CACHE_STORE
      self.api_key                = nil
      self.notification_callback  = nil
      self
    end

  end
end
