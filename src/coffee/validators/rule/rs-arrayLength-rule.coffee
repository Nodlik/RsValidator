define [], () ->

  (value, options) ->
    min = 0
    max = Number.POSITIVE_INFINITY

    if Array.isArray(options)
      if options.length > 0
        min = parseInt(options[0])
        if options.length > 1
          max = parseInt(options[1])
    else
      if 'min' of options
        min = parseInt(options['min'])
      if 'max' of options
        max = parseInt(options['max'])

    if isNaN(min) or isNaN(max)
      throw new Error('Invalid length parameters')

    if max < min
      throw new Error('Invalid length parameters')

    val = value
    if !Array.isArray(val)
      val = [val]

    if (val.length < min) or (val.length > max)
      return false

    return true