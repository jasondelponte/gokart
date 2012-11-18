define 'utilities/deferred', [], ->

  class Promise
    constructor: ->
      @_dones = []
      @_fails = []
      @_pendingFinish = false
      return

    _doDone: (data)->
      for done in @_dones
        done.apply(null, data)
      return

    _doFail: (data)->
      for fail in @_fails
        fail.apply(null, data)
      return

    doFinish: (isResolved, data)->
      @_pendingFinish = {isResolved: isResolved, data: data}

      if isResolved then @_doDone(data) else @_doFail(data)
      return

    done: (doneCb)->
      @_dones.push(doneCb)

      _pending = @_pendingFinish
      if _pending && _pending.isResolved
        @doFinish(_pending.isResolved, _pending.data)

      return @

    fail: (failCb)->
      @_fails.push(failCb)

      _pending = @_pendingFinish
      if _pending && !_pending.isResolved
        @doFinish(_pending.isResolved, _pending.data)
      return @

    then: (doneCb, failCb)->
      @_dones.push(doneCb) if doneCb?
      @_fails.push(failCb) if failCb?

      _pending = @_pendingFinish
      if _pending
        @doFinish(_pending.isResolved, _pending.data)
      return @


  class Deferred
    constructor: ->
      @_promise = null
      @_pendingFinish = null
      @_isFinished = false
      return

    _finish: (isResolved, data)->
      if @_isFinished
        return
      @_isFinished = true

      _promise = @_promise
      if _promise?
        _promise.doFinish(isResolved, data)
      else
        @_pendingFinish = {isResolved: isResolved, data: data}
      return
      
    resolve: (data...)->
      return @_finish(true, data)

    reject: (data...)->
      return @_finish(false, data)

    promise: ->
      promise = new Promise()
      @_promise = promise
      @_isFinished = false
      _pending = @_pendingFinish
      @_finish(_pending.isResolved, _pending.data) if _pending?
      return promise

  return Deferred