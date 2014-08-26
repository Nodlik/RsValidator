define ['rs-cast-error'], (RsCastError) ->

  (value) ->
    val = value.toString().trim()

    if !Array.isArray(val)
      val = [val]

    for v in val
      if (v != "1") and (v != "on") and (v != "true")
        return false

    return true

