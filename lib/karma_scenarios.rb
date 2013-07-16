require File.expand_path("../karma", __FILE__)

require "rack/server"
require "net/http"
require "webrick"

module Karma
  class Server
    attr_accessor :host, :port
    def initialize(app)
      @app = app
      @thread = nil

      @host = "127.0.0.1"
      @port = 3333
    end

    def call(env)
      if env["PATH_INFO"] == "/__identify__"
        [200, {}, [@app.object_id.to_s]]
      else
        begin
          @app.call(env)
        rescue StandardError => e
          @error = e unless @error
          raise e
        end
      end
    end

    def up?
      return false if @thread && @thread.join(0)

      res = Net::HTTP.start(@host, @port) { |http| http.get('/__identify__') }

      if res.is_a?(Net::HTTPSuccess) or res.is_a?(Net::HTTPRedirection)
        return res.body == @app.object_id.to_s
      end
    rescue SystemCallError
      return false
    end

    def access_log
      file = File.open(Rails.root.join("log", "test.log"), "a+")
      log = WEBrick::Log.new(file)
      [log, WEBrick::AccessLog::COMBINED_LOG_FORMAT]
    end

    def boot
      @thread = Thread.new do
        Rack::Server.start(
          :Host => @host,
          :Port => @port,
          :app => self,
          :AccessLog => [access_log],
          :environment => "test"
        )
      end

      Timeout.timeout(60) { @thread.join(0.1) until up? }
    rescue Timeout::Error
      raise "Rack application timed out during boot"
    else
      self
    end

    def shutdown
      @thread.kill
    end
  end


  class Scenarios
    def self.test!(opts = {})
      files = [Rails.root.join("test/karma/scenarios/*_test.coffee").to_s]

      ENV["RAILS_ENV"] = "test"
      ENV["RACK_ENV"] = "test"
      require Rails.root.join("config", "environment")
      server = Karma::Server.new(Rails.application)
      server.boot
      Karma.start!({:files => files, :adapter => :angular, :proxy => {
        "/" => "http://#{server.host}:#{server.port}/"
      }}.merge(opts))
      server.shutdown
    end
  end
end
