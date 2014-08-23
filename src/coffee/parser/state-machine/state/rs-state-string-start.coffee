define [], () ->

  class RsStateStringStart
    process: (parser, w) ->
      if w == '\\'
        return parser.state.stringEscape()

      if w == '"'
        parser.setTransition('stringStart', 'parameterValue')
        return parser.state.parameterValue()

      parser.setTransition('stringStart', 'stringStart')
      return @