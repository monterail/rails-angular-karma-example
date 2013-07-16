describe "MainController", ->
  scope = null
  ctrl = null
  httpBackend = null

  beforeEach(module('rails-angular-karma-example'))

  beforeEach inject ($controller, $rootScope, $httpBackend) ->
    # API Mocks
    httpBackend = $httpBackend
    httpBackend.when('GET', '/items.json').respond(
      {items: ["a", "b", "c"]}
    )

    httpBackend.expectGET("/items.json")
    scope = $rootScope.$new()
    ctrl = $controller("MainController", $scope: scope)
    httpBackend.flush()


  afterEach ->
    httpBackend.verifyNoOutstandingExpectation();
    httpBackend.verifyNoOutstandingRequest();


  it "should have items", ->
    expect(scope.items.length).toEqual(4)
    expect(scope.items.first()).toEqual(1) # sugar.js methods available

  it "should add new item", ->
    scope.addItem(5)
    expect(scope.items.length).toEqual(5)
    expect(scope.items.last()).toEqual(5)

  it "should fetch remote items", ->
    # scope.$apply()
    expect(scope.remoteItems).toEqual(["a", "b", "c"])
