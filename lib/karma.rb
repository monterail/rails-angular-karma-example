module Karma
  def self.start!(opts = {})
    Dir.mktmpdir do |dir|
      confjs = File.join(dir, "karma.conf.js")

      adapter = case opts[:adapter]
      when :angular then "ng-scenario"
      when :jasmine then "jasmine"
      end

      files = <<-EOS
        [
          #{opts[:files].map(&:dump).join(",\n")}
        ]
      EOS

      proxies = if opts[:proxy]
        "proxies : #{opts[:proxy].to_json},"
      else
        ""
      end

      File.open(confjs, "w") do |f|
        f.write <<-EOS
          module.exports = function (config) {
            config.set({
              basePath : '/',

              // Fix for "JASMINE is not supported anymore" warning
              frameworks : ["#{adapter}"],

              files : #{files},
              exclude : [],
              autoWatch : #{!opts[:single_run]},
              browsers : ['Chrome'],
              singleRun : #{!!opts[:single_run]},
              reporters : ['progress'],
              port : 9876,
              runnerPort : 9100,
              colors : true,
              logLevel : LOG_INFO,
              #{proxies}
              urlRoot : '/__karma__/',
              captureTimeout : 60000
            });
          }
        EOS
      end

      system "karma start #{confjs}"
    end
  end
end
