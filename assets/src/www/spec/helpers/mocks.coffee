define 'spec/mocks', [], ->

  Mocks = {}

  Mocks.ajax = jasmine.createSpy('AJAX Stub').andCallFake () ->
    return

  return Mocks