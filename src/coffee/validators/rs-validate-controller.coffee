define ['rs-email-rule', 'rs-notBlank-rule', 'rs-range-rule'
        'rs-string-validate', 'rs-array-validate', 'rs-int-validate',
        'rs-equal-rule', 'rs-bool-validate',
        'rs-notEqual-rule', 'rs-double-validate'
        'rs-length-rule', 'rs-arrayLength-rule',
        'rs-contain-rule', 'rs-notContain-rule',
        'rs-pattern-rule'], (EmailRule, NotBlankRule, RangeRule,
                             StringCast, ArrayCast, IntCast
                             EqualRule, BoolCast,
                             NotEqualRule, DoubleCast,
                             LengthRule, ArrayLengthRule,
                             ContainRule, NotContainRule,
                             PatternRule) ->

  class RsValidateController
    constructor: (validator) ->
      @validators = {}
      @types = {}

      @validator = validator

      @registerValidator('notBlank', NotBlankRule)
      @registerValidator('email', EmailRule)
      @registerValidator('range', RangeRule)
      @registerValidator('equal', EqualRule)
      @registerValidator('notEqual', NotEqualRule)
      @registerValidator('length', LengthRule)
      @registerValidator('arrayLength', ArrayLengthRule)
      @registerValidator('contain', ContainRule)
      @registerValidator('notContain', NotContainRule)
      @registerValidator('pattern', PatternRule)

      @registerTypeCaster('string', StringCast)
      @registerTypeCaster('array', ArrayCast)
      @registerTypeCaster('int', IntCast)
      @registerTypeCaster('bool', BoolCast)
      @registerTypeCaster('double', DoubleCast)

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