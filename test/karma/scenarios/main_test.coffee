describe "my test app", ->
  beforeEach ->
    browser().navigateTo "/"

  it "should have 4 items", ->
    expect(repeater('ul li').count()).toEqual(4)

  it "should add item", ->
    element(':button').click()
    expect(repeater('ul li').count()).toEqual(5)



