define [], () ->

  class RsStateParametersStart
    process: (parser, w) ->

      if /[a-zA-Z0-9]/.test(w)
        parser.setTransition('parametersStart', 'parameterValue')
        return parser.state.parameterValue()

      if w == '"'
        parser.setTransition('parametersStart', 'stringStart')
        return parser.state.stringStart()

      if w == ' '
        return @

      throw new Error('Invalid lexeme "' + w + '"');