define [], () ->

  class RsStateParametersStop
    process: (parser, w) ->

      if w == ","
        parser.setTransition('parametersStop', 'new')
        return parser.state.new()

      if w == ' '
        return @

      throw new Error('Invalid lexeme "' + w + '"');