define [], () ->

  class RsStateNew
    process: (parser, w) ->
      if /[a-zA-Z]/.test(w)
        parser.setTransition('new', 'word')
        return parser.state.word()

      if w == ' '
        return @

      throw new Error('Invalid lexeme "' + w + '"');