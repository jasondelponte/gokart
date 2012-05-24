modLoader.define 'libs/logger', (require,exports)->

  @appLoggerInstance = null

  logger = ->
    log = (args...)->
      console.log(args)
      return

    warn = (args...)->
      console.log(args)
      return

    debug = (args...)->
      console.error(args)
      return

    error = (args...)->
      console.error(args)
      return

    return {
      log: log
      warn: warn
      debug: debug
      error: error
    }

  _initLogger = =>
    @appLoggerInstance = logger()
    return

  exports.getInstance = (name) =>
    _initLogger() if !@appLoggerInstance
    return @appLoggerInstance

  exports.reset = =>
    delete @appLoggerInstance

  return