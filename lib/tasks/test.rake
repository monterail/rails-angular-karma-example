namespace :test do
  namespace :karma do
    task :unit => :environment do
      Dir.mktmpdir do |dir|
        sprockets = Rails.application.assets
        sprockets.append_path Rails.root.join("test/karma")

        files = sprockets.find_asset("unit.js").to_a.map {|e| e.pathname.to_s }
        files << Rails.root.join("test/karma/**/*_test.coffee").to_s
        confjs = File.join(dir, "karma.conf.js")

        File.open(confjs, "w") do |f|
          f.write <<-EOS
  basePath = '/'; // this is important - without this coffee files form gems will not be processed
  files = [
    JASMINE,
    JASMINE_ADAPTER,
    #{files.map(&:dump).join(",\n")}
  ]
  exclude = [];
  reporters = ['progress'];
  port = 9876;
  runnerPort = 9100;
  colors = true;
  logLevel = LOG_INFO;
  autoWatch = true;
  browsers = ['Chrome'] // or 'Firefox', 'Safari', 'PhantomJS'
  captureTimeout = 60000;
  singleRun = false;
  urlRoot = '/__karma__/';
          EOS
        end

        system "karma start #{confjs}"
      end
    end
  end
end
