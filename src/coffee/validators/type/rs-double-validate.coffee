define ['rs-cast-error'], (RsCastError) ->

  (value) ->
    val = value.trim()
    if val == ''
      return ''

    intval = parseFloat(val)

    if (isNaN(intval))
      return new RsCastError('double', value)

    if intval.toString() != val
      return new RsCastError('double', value)

    return intval