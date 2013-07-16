describe "MainController", ->
  scope = null
  ctrl = null

  beforeEach(module('rails-angular-karma-example'))

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ctrl = $controller("MainController", $scope: scope)


  it "should have items", ->
    expect(scope.items.length).toEqual(4)
    expect(scope.items.first()).toEqual(1) # sugar.js methods available

  it "should add new item", ->
    scope.addItem(5)
    expect(scope.items.length).toEqual(5)
    expect(scope.items.last()).toEqual(5)
