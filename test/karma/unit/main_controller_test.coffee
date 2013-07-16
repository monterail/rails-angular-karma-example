describe "MainController", ->
  beforeEach(module('rails-angular-karma-example'))

  it "should have items", inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ctrl = $controller("MainController", $scope: scope)
    expect(scope.items.length).toEqual(4)

  it "should add new item", inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ctrl = $controller("MainController", $scope: scope)
    scope.addItem(5)
    expect(scope.items.length).toEqual(5)
    expect(scope.items.last()).toEqual(5)
