define ['rs-contain-rule'], (ContainRule) ->

  (value, option) ->
    return !ContainRule(value, option)