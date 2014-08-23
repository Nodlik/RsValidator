define [], () ->

  (value) ->
    if !Array.isArray(value)
      return value != ""

    if value.length == 0
      return false

    for v in value
      if v == ""
        return false

    return true