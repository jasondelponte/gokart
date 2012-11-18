define 'spec/utilities/deferred', ['utilities/deferred'], (Deferred) ->
  describe 'Deferred Test', ->
    it 'should be able to create a deferred object, and get a promise from it', ->
      df = new Deferred()
      expect(df).toBeDefined()

      promise = df.promise()
      expect(promise).toBeDefined()

    it 'should be able to create a deferred which will resolve a promise, synchournously', ->
      df = new Deferred()
      promise = df.promise()

      wasFulfilled = false
      promise.done ->
        wasFulfilled = true

      df.resolve()

      waitsFor ->
        return wasFulfilled
      , 'promise to be fulfilled', 100

      runs ->
        expect(wasFulfilled).toBe(true)

    it 'should be able to create a deferred which will reject a promise, synchournously', ->
      df = new Deferred()
      promise = df.promise()

      wasRejected = false
      promise.fail ->
        wasRejected = true

      df.reject()

      waitsFor ->
        return wasRejected
      , 'promise to be rejected', 100

      runs ->
        expect(wasRejected).toBe(true)

    it 'should be able to resolve a promise before the promise is created, synchournously', ->
      df = new Deferred()
      promise = df.promise()

      df.resolve()

      wasFulfilled = false
      promise.done ->
        wasFulfilled = true

      waitsFor ->
        return wasFulfilled
      , 'promise to be fulfilled', 100

      runs ->
        expect(wasFulfilled).toBe(true)

    it 'should be able to reject a promise before the promise is created, synchournously', ->
      df = new Deferred()
      promise = df.promise()

      df.reject()

      wasRejected = false
      promise.fail ->
        wasRejected = true

      waitsFor ->
        return wasRejected
      , 'promise to be rejected', 100

      runs ->
        expect(wasRejected).toBe(true)

    it 'should be able to resolve a promise with data', ->
      df = new Deferred()
      promise = df.promise()

      df.resolve({myObj: true})

      wasFulfilled = false
      promise.done (obj)->
        expect(obj.myObj).toBe(true)
        wasFulfilled = true


      waitsFor ->
        return wasFulfilled
      , 'promise to be fulfilled', 100

      runs ->
        expect(wasFulfilled).toBe(true)

    it 'should be able to reject a promise with data', ->
      df = new Deferred()
      promise = df.promise()

      df.reject({myObj: true})

      wasRejected = false
      promise.fail (obj)->
        expect(obj.myObj).toBe(true)
        wasRejected = true


      waitsFor ->
        return wasRejected
      , 'promise to be reject', 100

      runs ->
        expect(wasRejected).toBe(true)

    it 'should be able to resolve a promise with multile datas', ->
      df = new Deferred()
      promise = df.promise()

      df.resolve({myObj: true}, {myObj2: true}, {myObj3: true})

      wasFulfilled = false
      promise.done (obj, obj2, obj3)->
        expect(obj.myObj).toBe(true)
        expect(obj2.myObj2).toBe(true)
        expect(obj3.myObj3).toBe(true)
        wasFulfilled = true


      waitsFor ->
        return wasFulfilled
      , 'promise to be fulfilled', 100

      runs ->
        expect(wasFulfilled).toBe(true)

    it 'should be able to reject a promise with multile datas', ->
      df = new Deferred()
      promise = df.promise()

      df.reject({myObj: true}, {myObj2: true}, {myObj3: true})

      wasRejected = false
      promise.fail (obj, obj2, obj3)->
        expect(obj.myObj).toBe(true)
        expect(obj2.myObj2).toBe(true)
        expect(obj3.myObj3).toBe(true)
        wasRejected = true


      waitsFor ->
        return wasRejected
      , 'promise to be rejected', 100

      runs ->
        expect(wasRejected).toBe(true)


    it 'should be able to resolve a promise with data, using the then', ->
      df = new Deferred()
      promise = df.promise()

      df.resolve({myObj: true})

      wasFulfilled = false
      promise.then (obj)->
        expect(obj.myObj).toBe(true)
        wasFulfilled = true
      , (obj)->
        expect('not to be called').toBe(true)
        wasFulfilled = false

      waitsFor ->
        return wasFulfilled
      , 'promise to be fulfilled', 100

      runs ->
        expect(wasFulfilled).toBe(true)


    it 'should be able to reject a promise with data, using the then', ->
      df = new Deferred()
      promise = df.promise()

      df.reject({myObj: true})

      wasRejected = false
      promise.then (obj)->
        expect('not to be called').toBe(true)
        wasRejected = false
      , (obj)->
        expect(obj.myObj).toBe(true)
        wasRejected = true

      waitsFor ->
        return wasRejected
      , 'promise to be rejected', 100

      runs ->
        expect(wasRejected).toBe(true)

  return