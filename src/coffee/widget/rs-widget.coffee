define ['rs-validator-settings', 'rs-widget-rule-reader',
        'rs-widget-type-reader', 'rs-error-parser',
        'rs-get-form-value', 'rs-cast-error'], (RsValidatorSettings, RuleReader,
                                                TypeReader, RsErrorParser,
                                                RsGetFormValue, RsCastError) ->

  class RsWidget
    constructor: ($widget, validateController, $parent) ->
      @$el = $widget
      @$parent = $parent

      @name = @_findName()
      @controller = validateController
      @config = new RsValidatorSettings()

      @validators = @controller.get(RuleReader(@$el))
      @typeCaster = @controller.getTypeCaster(TypeReader(@$el))
      @errorMessages = (new RsErrorParser()).parse(@$el.data('_error'))

      @$errorPlace = $('[data-_place="' + @name + '"]', @$parent)

    init: () ->
      @$el.off('RsValidator')
      if @config.isLiveValidate()
        @$el.on('keyup.RsValidator, change.RsValidator', () =>
          @process()
        );

    setConfig: (settings) ->
      @config.set(settings)

      @init()

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

      if errors.length == 0
        @config.valid(@)

        if @config.isSetStatusClass()
          @$el.removeClass(@config.getErrorClass())
          @$el.addClass(@config.getSuccessClass())

        if @config.useDefaultErrorHandler()
          @hideError()

        return true
      else
        @config.error(@, errors)

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