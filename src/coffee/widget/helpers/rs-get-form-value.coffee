define [], () ->

  class RsGetFormValue
    constructor: ($widget, $parent) ->
      @$el = $widget
      @$parent = $parent

    getValue: () ->
      if (@$el.prop('tagName') == 'INPUT')
        if (@$el.attr('type') == 'radio')
          return _getRadioButtonValue(@$el, @$parent)
        return @$el.val()

      return null;

    _getRadioButtonValue = ($el, $parent) ->
      $items = $('input[type="radio"]', $parent).filter('[name="' + $el.attr('name') + '"]:checked')
      if $items.length
        return $items.val()

      return ""