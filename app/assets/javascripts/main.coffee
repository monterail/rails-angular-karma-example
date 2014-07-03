app = angular.module('application', [])

app.directive "countries", ->
  restrict: "AE"
  replace: true
  templateUrl: "countries.html"
  scope:
    countries:  "=data"
  link: (scope, elem, attrs) ->
