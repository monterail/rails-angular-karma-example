@app = angular.module("rails-angular-karma-example", [])

@app.controller "MainController", ["$scope", ($scope) ->
  $scope.items = [1,2,3,4];

  $scope.addItem = (item) ->
    $scope.items.push(item)
]
