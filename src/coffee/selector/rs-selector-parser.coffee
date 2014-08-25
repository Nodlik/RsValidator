define [], () ->

  class RsSelectorParser
    parse: (selector) ->
      values = selector.split(',')

      namespaces = []
      for val in values
        if val.trim() != ''
          namespace = val.split('.')
          if namespace[0].trim() != ''
            row =
              namespace: namespace[0].trim()

            if namespace.length == 2
              if namespace[1].trim() != ''
                row.widget = namespace[1].trim()

            namespaces.push(row)

      namespaces