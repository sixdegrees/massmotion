require 'massmotion/config'
require 'massmotion/connection'
require 'massmotion/request'
require 'massmotion/models'
require 'hashie'

module Massmotion
  class Client

    attr_accessor *Config::VALID_OPTIONS_KEYS

    include Massmotion::Connection
    include Massmotion::Request

    # Initializes a new API object
    #
    # @param attrs [Hash]
    # @return [Massmotion::Client]
    def initialize(attrs={})
      attrs = Massmotion.options.merge(attrs)
      Config::VALID_OPTIONS_KEYS.each do |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      end
    end

    def credentials
      { :api_key  => api_key }
    end

  end
end