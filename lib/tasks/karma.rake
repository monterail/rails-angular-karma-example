namespace :test do
  task :karma => :"karma:all"

  namespace :karma do
    desc "Run all karma tests"

    task :all => :environment do
      require Rails.root.join("lib", "karma_scenarios")
      require Rails.root.join("lib", "karma_unit")

      puts "--> Running karma unit tests"
      Karma::Unit.test!(:single_run => true)
      puts "--> Running karma scenarios"
      Karma::Scenarios.test!(:single_run => true)
    end

    desc "Run scenarios tests (test/karma/scenarios)"
    task :scenarios => :environment do
      require Rails.root.join("lib", "karma_scenarios")
      Karma::Scenarios.test!
    end

    desc "Run unit tests (test/karma/unit)"
    task :unit => :environment do
      require Rails.root.join("lib", "karma_unit")
      Karma::Unit.test!
    end
  end
end
