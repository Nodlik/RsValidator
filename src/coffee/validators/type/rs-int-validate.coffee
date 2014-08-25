define ['rs-cast-error'], (RsCastError) ->

  (value) ->
    val = value.trim()
    intval = parseInt(val)

    if (isNaN(intval))
      return new RsCastError('int', value)

    if intval.toString() != val
      return new RsCastError('int', value)

    return intval