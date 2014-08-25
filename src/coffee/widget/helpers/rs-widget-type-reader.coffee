define ['rs-string-parser'], (RsStringParser) ->

  ($widget) ->
    if $widget.data('_type')
      data = (new RsStringParser()).parse($widget.data('_type'))
      if data.length != 1
        throw new Error('Invalid widget type condition')

      result = {
        'type': data[0]['word']
      }

      if 'parameters' of data[0]
        result['parameters'] = data[0]['parameters']

      return result

    if $widget.attr('type') == 'number'
      return {
        'type': 'number'
      }

    {
      'type': 'string'
    }