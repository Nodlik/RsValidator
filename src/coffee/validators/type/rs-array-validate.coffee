define ['rs-cast-error'], (RsCastError) ->

  (value) ->
    if (!Array.isArray(value))
      return new RsCastError('array', value)

    return val