require 'massmotion/core_ext/hash'
require 'massmotion/client'
require 'massmotion/config'

module Massmotion
  extend Config
  class << self
    # Alias for Massmotion::Client.new
    #
    # @return [Massmotion::Client]
    def new(options={})
      Massmotion::Client.new(options)
    end

    # Delegate to Massmotion::Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end

end
