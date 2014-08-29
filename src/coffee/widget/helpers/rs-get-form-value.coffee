define [], () ->

  class RsGetFormValue
    constructor: ($widget, $parent) ->
      @$el = $widget
      @$parent = $parent

    getValue: () ->
      if (@$el.prop('tagName') == 'INPUT')
        if (@$el.attr('type') == 'radio')
          return _getRadioButtonValue(@$el, @$parent)
        if (@$el.attr('type') == 'checkbox')
          return @$el.is(':checked')
        return @$el.val()
      if (@$el.prop('tagName') == 'SELECT')
        return @$el.val()
      if (@$el.prop('tagName') == 'TEXTAREA')
        return @$el.val()

      return @$el.text()

    _getRadioButtonValue = ($el, $parent) ->
      $items = $('input[type="radio"]', $parent).filter('[name="' + $el.attr('name') + '"]:checked')
      if $items.length
        return $items.val()

      return ""