define [], () ->

  class RsStateStringEscape
    process: (parser, w) ->

      if w == '"'
        parser.setTransition('stringEscape', 'stringStart')
        return parser.state.stringStart()

      return @