define [], () ->

  (value, needValidate = true) ->
    if !needValidate
      return true

    emailPattern = /^([\w.-]+)@([\w.-]+)\.([a-zA-Z.]{2,6})$/i;

    if !Array.isArray(value)
      if value.length == 0
        return true
      val = value.trim()
      return emailPattern.test val


    for v in value
      val = v.trim()
      if !(val.match emailPattern)
        return false

    return true