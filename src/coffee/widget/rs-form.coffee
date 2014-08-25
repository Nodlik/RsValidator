define [], () ->

  class RsForm
    $el = null

    constructor: ($form, validator) ->
      $el = $form
      rsValidator = validator

      @name = _findName()

      $items = $('[data-_rule], [data-_namespace], [data-_error], [data-_name], [data-_validate]', $el)
      self = @
      $items.each () ->
        if !($(@).prop('tagName') == 'FORM')
          rsValidator.processWidget($(@), self.name)

      if (validator.getConfig().isAutoValidate()) || ($el.data('_role') == 'auto-validate')
        $el.on('submit.RsValidator', () ->
          alert('validation')
        );

    getName: () ->
      @name

    _findName = () ->
      if $el.data('_namespace')
        return $el.data('_namespace')

      if $el.attr('name')
        return $el.attr('name')

      if $el.attr('id')
        return $el.attr('id')

      throw new Error('Invalid form definition')