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

    def self.find opts={}
      if opts.is_a?(Hash)
        client.get(path, opts).map { |k,v| new({ 'id' => k.to_i }.merge(v)) }
      else
        id = opts.to_s
        attrs = { 'id' => id.to_i }.merge client.get([path, id].join("/"))[id]
        new(attrs)
      end
    end

    def self.all
      self.find({})
    end

    def reload
      
    end

    def path
      [self.class.path, id].join("/")
    end

    def save
      if id.nil?
        job = client.post(self.class.path, to_hash)
      else
        job = client.put(path, to_hash)
      end
      raise "UpdateError: #{job['request_result']}" if job['id'] == 0
      return Job.new(job)
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

    def playlist
      
    end

  end

  class Job < Model
    path "jobs"
  end


end