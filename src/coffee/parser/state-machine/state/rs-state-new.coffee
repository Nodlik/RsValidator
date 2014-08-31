define [], () ->

  class RsStateNew
    process: (parser, w) ->
      if /[a-zA-Z]/.test(w)
        parser.setTransition('new', 'word')
        return parser.state.word()

      if w == ' ' or w == '\n' or w == '\r'
        return @

      throw new Error('Invalid lexeme "' + w + '"');