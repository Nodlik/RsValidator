define [], () ->

  (value, option) ->
    condition = null

    if Array.isArray(option)
      if option.length == 0
        throw new Error('Invalid equal condition')
      condition = option[0]

    else
      condition = option

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

    for v in val
      if !(checkValue(v, condition, typeof v))
        return false

    return true