describe 'Module Loader Spec', ->

  beforeEach ->
    modLoader.clearAll()
    return

  it 'should be defined as a global object', ->
    expect(modLoader).toBeDefined()
    return

  it 'should be able to define a new module', ->
    modLoader.define 'testmod-1', (require, exports)->
      return

    expect(modLoader.isDefined('testmod-1')).toBe(true)
    return

  it 'should be able to define a new module with exports', ->
    modLoader.define 'testmod-1', (require, exports)->
      exports.isLoaded = true
      return

    exports = modLoader.require 'testmod-1'
    expect(exports).toBeDefined()
    expect(exports.isLoaded).toBe(true)
    return

  it 'should only load a module once and cache the exports', ->
    numLoaded = 0
    modLoader.define 'testmod-1', (require, exports)->
      numLoaded++
      exports.isLoaded = true
      return

    exports = modLoader.require 'testmod-1'
    expect(exports).toBeDefined()
    expect(exports.isLoaded).toBe(true)
    expect(numLoaded).toBe(1)

    exports = modLoader.require 'testmod-1'
    expect(exports).toBeDefined()
    expect(exports.isLoaded).toBe(true)
    expect(numLoaded).toBe(1)

    return