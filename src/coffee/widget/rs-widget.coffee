define ['rs-validator-settings', 'rs-widget-rule-reader',
        'rs-widget-type-reader', 'rs-error-parser',
        'rs-get-form-value', 'rs-cast-error'], (RsValidatorSettings, RuleReader,
                                                TypeReader, RsErrorParser,
                                                RsGetFormValue, RsCastError) ->

  class RsWidget
    constructor: ($widget, validateController, $parent = null) ->
      @$el = $widget
      @$parent = $parent

      if (@$parent == null)
        @$parent = $("body")

      @name = @_findName()
      @controller = validateController
      @config = new RsValidatorSettings()

      @validators = @controller.get(RuleReader(@$el))
      @typeCaster = @controller.getTypeCaster(TypeReader(@$el))
      @errorMessages = (new RsErrorParser()).parse(@$el.data('_error'))

      @$errorPlace = $('[data-_place="' + @name + '"]', @$parent)

      @_isValid = null

      @handlers = {}

    init: () ->
      @$el.off('RsValidator')

      if @$el.attr('type') == 'radio'
        $('input[type="radio"]', @$parent).filter('[name="' + @$el.attr('name') + '"]').off('RsValidator')

      if @config.isLiveValidate()
        if (@$el.attr('type') != 'checkbox') and (@$el.attr('type') != 'radio') and (@$el.prop('tagName') != 'SELECT')
          @$el.on('keyup.RsValidator, change.RsValidator', () =>
            @process()

            true
          )
        else if (@$el.attr('type') == 'checkbox') or (@$el.prop('tagName') == 'SELECT')
          @$el.on('click.RsValidator', () =>
            @process()

            true
          )
        else if (@$el.attr('type') == 'radio')
          $('input[type="radio"]', @$parent).filter('[name="' + @$el.attr('name') + '"]').on('click.RsValidator', () =>
            @process()

            true
          )

    addRule: (rule, option) ->
      rules = {}
      rules[rule] = option

      @validators = $.extend(@validators, @controller.get(rules));

    addRules: (rules) ->
      @validators = $.extend(@validators, @controller.get(rules));

    setConfig: (settings) ->
      @config.set(settings)

      @init()

    trigger: (event) ->
      if event of @handlers
        for c in @handlers[event]
          c.apply(@controller.validator, [@])

    on: (event, callback) ->
      if !(event of @handlers)
        @handlers[event] = []

      @handlers[event].push(callback)

    setLocale: (lang) ->
      @config.settings.locale = lang

    getValue: () ->
      getter = new RsGetFormValue(@$el, @$parent)

      @typeCaster['func'].apply(@controller, [getter.getValue(), @typeCaster['body']])

    getName: () ->
      @name

    validate: () ->
      errors = []
      value = @getValue()
      if value instanceof RsCastError
        return ['type']

      for name, validator of @validators
        if !(validator['func'](value, validator['body']))
          errors.push(name)

      errors

    isValid: () ->
      @validate().length > 0

    getErrorText: (rule, lang = '') ->
      if lang == ''
        lang = @config.getLocale()

      if !(rule of @errorMessages)
        return ''

      if !(lang of @errorMessages[rule])
        if !('global' of @errorMessages[rule])
          return ''
        else
          return @errorMessages[rule]['global']
      else
        return @errorMessages[rule][lang]

    addErrorText: (rule, text, lang = '') ->
      if lang == ''
        lang = @config.getLocale()

      if !(rule of @errorMessages)
        @errorMessages[rule] = {}

      @errorMessages[rule][lang] = text

    renderError: (validateErrors) ->
      if @$errorPlace.length
        @$errorPlace.show()

        errorsMessage = []
        for error in validateErrors
          message = @getErrorText(error)
          if message != ''
            errorsMessage.push(message)

        @$errorPlace.text(errorsMessage.join(', '))

    hideError: () ->
      if @$errorPlace.length
        @$errorPlace.hide()
        @$errorPlace.text('')

    process: () ->
      errors = @validate()

      if @_isValid == null
        @trigger('change')
        @_isValid = (errors.length == 0)

      if errors.length == 0
        @trigger('valid')

        if @_isValid == false
          @_isValid = true
          @trigger('change')

        @config.valid.apply(@controller.validator, [@])

        if @config.isSetStatusClass()
          @$el.removeClass(@config.getErrorClass())
          @$el.addClass(@config.getSuccessClass())

        if @config.useDefaultErrorHandler()
          @hideError()

        return true
      else
        @trigger('error')

        if @_isValid == true
          @_isValid = false
          @trigger('change')

        @config.error.apply(@controller.validator, [@, errors])

        if @config.isSetStatusClass()
          @$el.removeClass(@config.getSuccessClass())
          @$el.addClass(@config.getErrorClass())

        if @config.useDefaultErrorHandler()
          @renderError(errors)

        return false

    _findName: () ->
      if @$el.data('_name')
        return @$el.data('_name')

      if @$el.attr('name')
        return @$el.attr('name')

      if @$el.attr('id')
        return @$el.attr('id')

      throw new Error('Invalid widget name')