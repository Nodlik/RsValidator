define ['rs-cast-error'], (RsCastError) ->

  (value, data = []) ->
    if (Array.isArray(value))
      return value

    delimiter = ','
    if data.length == 2
      delimiter = data[1]

    itemCaster = this.types['string']
    if data.length > 0
      if !(data[0] of this.types)
        throw new Error('Invalid array type argument "' + data[0] + '"')

      itemCaster = this.types[data[0]]

    result = []
    values = value.split(delimiter)
    for val in values
      castedValue = itemCaster.apply(this, [val.trim()])
      if castedValue instanceof RsCastError
        return new RsCastError('array', value)

      result.push(castedValue)

    return result