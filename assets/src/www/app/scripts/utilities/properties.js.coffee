define 'utilities/properties', [], ->

  _buildProp = (cont, propStore, isStatic)->
    return (value) ->
      if value != undefined && !isStatic
        cont[propStore] = value
      else if value != undefined && isStatic
        console.error('unable to set static property '+propStore+' to:',value)

      return cont[propStore]

  add = (cont, props)->
    for own prop,rules of props
      propStore = '__auto__'+prop
      cont[propStore] = if rules.value != undefined then rules.value else null
      cont[prop] = _buildProp(cont, propStore, rules.static)
    return

  return {
    add: add
  }