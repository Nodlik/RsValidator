define ['rs-rule-parser'], (RsRuleParser) ->

  ($widget) ->
    data = []

    parser = new RsRuleParser()

    if $widget.data('_rule')
      data = parser.parse( $widget.data('_rule') )

    if $widget.attr('required')
      data['notBlank'] = true

    if $widget.attr('type') == 'email'
      data['email'] = true

    data