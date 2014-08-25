define [], () ->

  class RsValidatorSettings
    constructor: () ->
      @settings =
        locale: 'global',
        autoValidate: false
        liveValidate: true
        successClass: 'success'
        errorClass: 'error'
        setStatusClass: true # Добавлять ли success и error классы в зависимости от статуса валидации
        defaultErrorHandler: true
        onError: (widget, error) ->

        onValid: (widget) ->

    set: (settings) ->
      @settings = $.extend(settings);

    getLocale: () ->
      @settings.locale

    error: (widget, error) ->
      @settings.onError(widget, error)

    valid: (widget) ->
      @settings.onValid(widget)

    isAutoValidate: () ->
      @settings.autoValidate

    isLiveValidate: () ->
      @settings.autoValidate

    getSuccessClass: () ->
      @settings.successClass

    getErrorClass: () ->
      @settings.errorClass

    isSetStatusClass: () ->
      @settings.setStatusClass

    useDefaultErrorHandler: () ->
      @settings.defaultErrorHandler
