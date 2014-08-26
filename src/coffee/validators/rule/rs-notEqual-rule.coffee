define ['rs-equal-rule'], (EqualRule) ->

  (value, option) ->
    return !EqualRule(value, option)