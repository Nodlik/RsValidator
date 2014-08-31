define [], () ->

  class RsStateWord
    process: (parser, w) ->
      if w == '\n'
        parser.setTransition('word', 'new')
        return parser.state.new()

      if w == '\r'
        parser.setTransition('word', 'new')
        return parser.state.new()

      if /[a-zA-Z]/.test(w)
        parser.setTransition('word', 'word')
        return @

      if w == ','
        parser.setTransition('word', 'new')
        return parser.state.new()

      if w == '('
        parser.setTransition('word', 'parametersStart')
        return parser.state.parametersStart()

      throw new Error('Invalid lexeme "' + w + '"');