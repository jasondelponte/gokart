describe 'Properties generator', ->
  Properties = modLoader.require 'helpers/properties'
  
  it 'should be able to add properties to a object', ->
    obj = {}
    Properties.add obj,
      val1: {value:'test 1 value',static:true}
      val2: {value: 'test 2 value'}

    expect(obj.__auto__val1).toBe('test 1 value')
    expect(obj.val1()).toBe('test 1 value')
    expect(obj.__auto__val2).toBe('test 2 value')
    expect(obj.val2()).toBe('test 2 value')

    obj.val1('failed value')
    expect(obj.val1()).toBe('test 1 value')

    obj.val2('failed value 2')
    expect(obj.val2()).toBe('failed value 2')
    return
  return