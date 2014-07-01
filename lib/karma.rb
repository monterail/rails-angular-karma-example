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
              browsers : ['Firefox'],
              singleRun : #{!!opts[:single_run]},
              reporters : ['progress'],
              port : 9876,
              runnerPort : 9100,
              colors : true,
              #{proxies}
              urlRoot : '/__karma__/',
              preprocessors: { '**/*.coffee': ['coffee'] },
              coffeePreprocessor: {
                options: {
                  bare: true,
                  sourceMap: false
                },
                transformPath: function(path) {
                  return path.replace(/\.coffee$/, '.js');
                }
              },
              captureTimeout : 60000
            });
          }
        EOS
      end

      system "karma start #{confjs}"
    end
  end
end
