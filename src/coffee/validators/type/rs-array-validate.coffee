define ['rs-cast-error'], (RsCastError) ->

  (value, data = []) ->
    values = []
    result = []

    if (Array.isArray(value))
      values =  value
    else
      if (value == "") or (value == null)
        return []

      delimiter = ','
      if data.length == 2
        delimiter = data[1]

      values = value.split(delimiter)

    itemCaster = this.types['string']
    if data.length > 0
      if !(data[0] of this.types)
        throw new Error('Invalid array type argument "' + data[0] + '"')

      itemCaster = this.types[data[0]]

    for val in values
      castedValue = itemCaster.apply(this, [val.trim()])
      if castedValue instanceof RsCastError
        return new RsCastError('array', value)

      result.push(castedValue)

    return result