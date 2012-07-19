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
        client.get(path, opts).map { |attrs| new(attrs) }
      else
        new client.get([path, opts.to_s].join("/"))
      end
    end

    def self.all
      self.find({})
    end

    def self.create attrs
      begin
        client.post(path, attrs.to_json)        
      rescue => e
        puts "Error: #{e.to_s}"
        false
      end
    end

    def reload
       
    end

    def path
      [self.class.path, id].join("/")
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

    def self.create attrs={}
      attrs['notification_callback'] ||= client.notification_callback if client.notification_callback
      super(attrs)
    end

    def playlist
      @playlist ||= client.get([path, 'playlist'].join("/"))
    end

    def job(refresh=false)
      return unless current_job
      if !refresh
        Job.new(current_job.to_hash)
      elsif current_job.id > 0
        Job.find(current_job.id)
      end
    end

  end

  class Job < Model
    path "jobs"
  end


end
