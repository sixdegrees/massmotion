require 'hashie'

module Massmotion
  
  class Model < ::Hashie::Mash

    def self.path p=nil
      @path = p.gsub(/\/$/,"") unless p.nil?
      @path
    end

    def self.client
      @client = Massmotion::Client.new
    end

    def client
      self.class.client
    end

    def self.all
      client.get(path).map { |k,v| new({ :id => k.to_i }.merge(v)) }
    end

    def self.get id
      attrs = client.get([path, id].join("/"))
      new(attrs[id.to_s])
    end

    def path
      [self.class.path, id].join("/")
    end

    def save
      client.put(path, to_hash)
    end

    def destroy
      client.delete(path)
    end

  end

  class QualityProfile < Model
    path "quality_profile_lists"
  end

  class Resource < Model
    path "resources"
  end

  class Job < Model
    path "jobs"
  end


end