# Rails app with angular.js and karma test runner

## Install

```shell
npm install -g karma
bundle install
```

## Run unit tests with file watcher

```shell
rake test:karma:unit
```

Now any change in app/assets or test/karma/unit files will rerun tests automatically

See `app/assets/javascripts/controllers/main.js.coffee` for example controller and `test/karma/unit/main_controller_test.coffee` for example test
