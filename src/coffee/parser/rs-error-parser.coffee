define ['rs-string-parser'], (RsStringParser) ->

  class RsErrorParser
    parse: (errors) ->
      try
        return JSON.parse(errors);
      catch e
        return _parseString(errors)

    _parseString = (errorString) ->
      if !errorString
        return {}

      parser = new RsStringParser()
      data = parser.parse(errorString)

      result = {}
      for row in data
        if not ('parameters' of row)
          throw new Error('Invalid error message string')

        errors = {}
        for message in row['parameters']
          if message.indexOf(':') != -1
            val = '{' + message + '}'
            error = JSON.parse(val)
            lang = Object.keys(error)[0]
            errors[lang] = error[lang]
          else
            errors = {'global': message}

        result[row['word']] = errors

      result