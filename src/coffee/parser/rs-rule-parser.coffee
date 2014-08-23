define ['rs-string-parser'], (RsStringParser) ->

  class RsRuleParser
    parse: (rules) ->
      try
        return JSON.parse(rules);
      catch e
        return _parseString(rules)

    _parseString = (rulesString) ->
      parser = new RsStringParser()
      data = parser.parse(rulesString)

      rules = {}
      for row in data
        value = true
        if 'parameters' of row
          value = row['parameters']
          if (value.length == 1) and (value[0] == 'false')
            value = false

        rules[row['word']] = value

      rules