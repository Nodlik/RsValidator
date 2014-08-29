define [], () ->

  (value, options) ->
    return (new RegExp(options)).test(value)
