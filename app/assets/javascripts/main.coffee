shared = angular.module('shared', ['jmdobry.angular-cache'])

angular.module('shared').config [
  '$provide', '$httpProvider', 'Rails',
  ($provide, $httpProvider, Rails) ->
    $provide.factory 'railsAssetsInterceptor', ['$angularCacheFactory', ($angularCacheFactory) ->
      request: (config) ->
        if assetUrl = Rails.templates[config.url]
          config.url = assetUrl

        config
    ]

    $httpProvider.interceptors.push('railsAssetsInterceptor')
]

app = angular.module('application', ['shared'])

app.controller 'DummyController', ['$scope', ($scope) ->
  $scope.data = [{
    name: 'Poland'
  }, {
    name: 'Italy'
  }, {
    name: 'France'
  }]
]

app.directive "countries", ->
  restrict: "AE"
  replace: true
  templateUrl: "countries.html"
  scope:
    countries:  "=data"
  link: (scope, elem, attrs) ->

