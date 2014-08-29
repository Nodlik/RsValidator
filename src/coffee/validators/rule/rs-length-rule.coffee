define [], () ->

  (value, options) ->
    min = 0
    max = Number.POSITIVE_INFINITY
    arrayValidate = false

    if Array.isArray(options)
      if options.length > 0
        min = parseInt(options[0])
        if options.length > 1
          max = parseInt(options[1])
        if options.length > 2
          arrayValidate = 'true' == options[2]
    else
      if 'min' of options
        min = parseInt(options['min'])
      if 'max' of options
        max = parseInt(options['max'])
      if 'array' of options
        arrayValidate = 'true' == options['array']

    if isNaN(min) or isNaN(max)
      throw new Error('Invalid length parameters')

    if max < min
      throw new Error('Invalid length parameters')

    val = value

    if !Array.isArray(val)
      if arrayValidate
        throw new Error('Invalid validate type')
      val = [val]

    if arrayValidate
      return (value.length >= min) and (value.length <= max)
    else
      for v in val
        if (v.length < min) or (v.length > max)
          return false

    return true