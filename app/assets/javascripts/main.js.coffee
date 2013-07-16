@app = angular.module("rails-angular-karma-example", [])

@app.controller "MainController", ["$scope", "$http", ($scope, $http) ->
  $scope.items = [1,2,3,4];

  $scope.addItem = (item) ->
    $scope.items.push(item)

  $http.get("/items.json").then (e) ->
    $scope.remoteItems = e.data.items
]
