define [], () ->

  (value, option) ->
    condition = option

    if Array.isArray(option)
      if option.length == 0
        throw new Error('Invalid equal condition')

    else
      condition = [condition]

    val = value
    if !Array.isArray(val)
      val = [val]

    checkValue = (checkVal, checkCondition, type) ->
      if type == 'string'
        return checkVal == checkCondition
      if type == 'boolean'
        if checkCondition == "true"
          return checkVal == true
        else
          return checkVal == false
      if type == 'number'
        return checkVal == parseFloat(checkCondition)

      return false

    for c in condition
      contains = false
      for v in val
        if (checkValue(v, c, typeof v))
          contains = true

      if (!contains)
        return false

    return true