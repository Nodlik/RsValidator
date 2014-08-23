define [], () ->

  class RsStateTransition
    transition = {
      'new': {
        'word': (parser, symbol) ->
          parser.word = symbol
      },

      'word': {
        'word': (parser, symbol) ->
          parser.word += symbol

        'new': (parser, symbol) ->
          if parser.word != ""
            parser.data.push
              word: parser.word

          parser.word = ""

        'parametersStart': (parser, symbol) ->
          parser.data.push
            word: parser.word

          parser.word = ""
          parser.parameters = [];
      }

      'parametersStart': {
        'parameterValue':  (parser, symbol) ->
          parser.parameter = symbol

        'stringStart':   (parser, symbol) ->
          parser.parameter += '"'
      }

      'parameterNew': {
        'parameterValue':  (parser, symbol) ->
          parser.parameter += symbol

        'stringStart':   (parser, symbol) ->
          parser.parameter += '"'
      }

      'parameterValue': {
        'parameterValue':  (parser, symbol) ->
          parser.parameter += symbol

        'parameterNew': (parser, symbol) ->
          if (parser.parameter[0] == '"') and (parser.parameter[parser.parameter.length - 1] == '"') and (parser.parameter.split('"').length == 3)
            parser.parameter = parser.parameter.slice(0, -1)
            parser.parameter = parser.parameter.substr(1)

          parser.parameters.push(parser.parameter)
          parser.parameter = ""

        'parametersStop': (parser, symbol) ->
          if (parser.parameter[0] == '"') and (parser.parameter[parser.parameter.length - 1] == '"') and (parser.parameter.split('"').length == 3)
            parser.parameter = parser.parameter.slice(0, -1)
            parser.parameter = parser.parameter.substr(1)

          parser.parameters.push(parser.parameter)
          parser.data[parser.data.length - 1]['parameters'] = parser.parameters;

          parser.parameters = []
          parser.parameter = ""

        'stringStart':   (parser, symbol) ->
          parser.parameter += '"'
      }

      'parametersStop': {
        'new': (parser, symbol) ->
          parser.word = ""
      }

      'stringEscape': {
        'stringStart': (parser, symbol) ->
          parser.parameter += '\\"'
      }

      'stringStart': {
        'stringStart': (parser, symbol) ->
          parser.parameter += symbol

        'parameterValue':  (parser, symbol) ->
          parser.parameter += '"'
      }
    }

    setTransition: (oldState, newState, parser, symbol) ->
      transition[oldState][newState](parser, symbol)