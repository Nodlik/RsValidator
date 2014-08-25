define [], () ->

  (value, options) ->
    console.log(options)

    min = Number.NEGATIVE_INFINITY
    max = Number.POSITIVE_INFINITY

    if Array.isArray(options)
      if options.length > 0
        min = parseFloat(options[0])
        if options.length > 1
          max = parseFloat(options[1])
    else
      if 'min' of options
        min = parseFloat(options['min'])
      if 'max' of options
        max = parseFloat(options['max'])

    if isNaN(min) or isNaN(max)
      throw new Error('Invalid range parameters')

    if max < min
      throw new Error('Invalid range parameters')

    val = value
    if !Array.isArray(val)
      val = [val]

    for v in val
      if (v < min) or (v > max)
        return false

    return true