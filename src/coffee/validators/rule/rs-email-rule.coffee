define [], () ->

  (value) ->
    emailPattern = /^([\w.-]+)@([\w.-]+)\.([a-zA-Z.]{2,6})$/i;

    if !Array.isArray(value)
      val = value.trim()
      return emailPattern.test val

    if value.length == 0
      return true

    for v in value
      val = v.trim()
      if !(val.match emailPattern)
        return false

    return true