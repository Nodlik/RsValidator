define [], () ->

  class RsStateParameterValue
    process: (parser, w) ->
      if /[a-zA-Z0-9: ]/.test(w)
        parser.setTransition('parameterValue', 'parameterValue')
        return @

      if w == ','
        parser.setTransition('parameterValue', 'parameterNew')
        return parser.state.parameterNew()

      if w == ')'
        parser.setTransition('parameterValue', 'parametersStop')
        return parser.state.parametersStop()

      if w == '"'
        parser.setTransition('parameterValue', 'stringStart')
        return parser.state.stringStart()

      throw new Error('Invalid lexeme "' + w + '"');