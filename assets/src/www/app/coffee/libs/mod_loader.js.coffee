# Builds a module loader tool which pulls in functions only once
# and returns the exports for each time it is required after that

@modLoader = (->
  _modules = {}

  require = (name)->
    mod = _modules[name]

    if !mod
      console.error 'Failed to load module '+name+', as it does exist.'
      return {}

    exports = mod.exports
    if !exports
      exports = mod.exports = {}
      mod.builder(require, exports)

    return exports

  define = (name, builder)->
    _modules[name] =
      builder: builder
      exports: null
    return

  isDefined = (name)->
    return _modules[name]?

  isLoaded = (name)->
    return _modules[name]? && _modules[name].exports

  clearAll = ->
    _modules = {}
    return

  return {
    require:  require
    define:   define
    isDefined: isDefined
    isLoaded: isLoaded
    clearAll: clearAll
  }
)()