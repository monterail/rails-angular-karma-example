module Karma
  def self.start!(opts = {})
    Dir.mktmpdir do |dir|
      confjs = File.join(dir, "karma.conf.js")

      adapter = case opts[:adapter]
      when :angular then "ANGULAR_SCENARIO"
      when :jasmine then "JASMINE"
      end

      files = <<-EOS
        [
          #{adapter},
          #{adapter}_ADAPTER,
          #{opts[:files].map(&:dump).join(",\n")}
        ]
      EOS

      proxies = if opts[:proxy]
        "proxies = #{opts[:proxy].to_json};"
      else
        ""
      end

      File.open(confjs, "w") do |f|
        f.write <<-EOS
          basePath = '/'; // this is important - without this coffee files form gems will not be processed
          files = #{files};
          exclude = [];
          reporters = ['progress'];
          port = 9876;
          runnerPort = 9100;
          colors = true;
          logLevel = LOG_INFO;
          autoWatch = #{!opts[:single_run]};;
          browsers = ['Chrome'] // or 'Firefox', 'Safari', 'PhantomJS'
          captureTimeout = 60000;
          singleRun = #{!!opts[:single_run]};
          #{proxies}
          urlRoot = '/__karma__/';
        EOS
      end

      system "karma start #{confjs}"
    end
  end
end
