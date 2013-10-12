# Rails app with angular.js and karma test runner

!["Example"](https://dl.dropbox.com/s/62pc1b20ow3mnr0/2013-07-16_at_8.45.50_PM.png)

## Install

```shell
npm install -g karma
npm install -g karma-ng-scenario
bundle install
```

## Run unit tests with file watcher

```shell
rake test:karma:all        # Run all karma tests
rake test:karma:scenarios  # Run scenarios tests (test/karma/scenarios)
rake test:karma:unit       # Run unit tests (test/karma/unit)
```

For `test:karma:unit` and `test:karma:scenarios` any change made to app/assets or test/karma files will rerun tests automatically. `test:karma:all` is a single run that can be used in CI.

See:

*  `app/assets/javascripts/controllers/main.js.coffee` for example controller
*  `test/karma/unit/main_controller_test.coffee` for example unit test
*  `test/karma/scenarios/main_test.coffee` for example scenario
