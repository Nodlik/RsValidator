define ['rs-email-rule', 'rs-notBlank-rule',
        'rs-string-validate', 'rs-array-validate', 'rs-int-validate'], (EmailRule, NotBlankRule,
                                StringCast, ArrayCast, IntCast) ->

  class RsValidateController
    constructor: () ->
      @validators = {}
      @types = {}

      @registerValidator('notBlank', NotBlankRule)
      @registerValidator('email', EmailRule)

      @registerTypeCaster('string', StringCast)
      @registerTypeCaster('array', ArrayCast)
      @registerTypeCaster('int', IntCast)

    registerValidator: (validatorName, validateFunction) ->
      @validators[validatorName] = validateFunction

    registerTypeCaster: (type, castFunction) ->
      @types[type] = castFunction

    get: (rules) ->
      result = {}

      for rule, body of rules
        if !(rule of @validators)
          throw new Error('Invalid validator name ' + rule)

        result[rule] =
          'func': @validators[rule]
          'body': body

      result

    getTypeCaster: (type) ->
      if !(type['type'] of @types)
        throw new Error('Invalid value type ' + type)

      result =
        'func': @types[type['type']]
        'body': null

      if 'parameters' of type
        result['body'] = type['parameters']

      return result