define [], () ->

  class RsCastError

    constructor: (type, value) ->
      @type = type
      @value = value