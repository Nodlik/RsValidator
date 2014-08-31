define [], () ->

  class RsStateParameterNew
    process: (parser, w) ->

      if /[a-zA-Z0-9]/.test(w)
        parser.setTransition('parameterNew', 'parameterValue')
        return parser.state.parameterValue()

      if w == '"'
        parser.setTransition('parameterNew', 'stringStart')
        return parser.state.stringStart()

      if w == ' ' or w == '\n' or w == '\r'
        return @

      throw new Error('Invalid lexeme "' + w + '"');