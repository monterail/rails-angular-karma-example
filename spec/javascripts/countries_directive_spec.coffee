describe 'Countries Directive', ->
  $compile = $scope = $httpBackend = element = null

  beforeEach ->
    shared = angular.module('shared')
    shared.constant('Rails', { env: 'test', templates: {} })

    module('application', 'countries.html')

  beforeEach(inject((_$compile_, _$rootScope_, _$httpBackend_) ->
    $scope = _$rootScope_
    $compile = _$compile_
    $httpBackend = _$httpBackend_
  ))

  beforeEach ->
    $scope.countries = [{
      code: 'PL',
      name: 'Poland'
    }, {
      code: 'UK',
      name: 'United Kingdom'
    }, {
      code: 'IT',
      name: 'Italy'
    }]
    element = $compile('<countries data="countries"></countries>')($scope)
    $scope.$digest()

  it 'renders list of countries', ->
    expect(element.html()).toContain('Poland')
