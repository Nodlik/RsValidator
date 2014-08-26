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
        defaultErrorHandler: true # Обработчики ошибок по умолчанию
        globalNamespace: false,
        onError: (widget, error) ->


        onValid: (widget) ->


        onChange: (widget) ->


      @change = @settings.onChange
      @error = @settings.onError
      @valid = @settings.onValid


    set: (settings) ->
      @settings = $.extend(@settings, settings);

      @change = @settings.onChange
      @error = @settings.onError
      @valid = @settings.onValid

    getLocale: () ->
      @settings.locale

    isAutoValidate: () ->
      @settings.autoValidate

    isLiveValidate: () ->
      @settings.liveValidate

    getSuccessClass: () ->
      @settings.successClass

    getErrorClass: () ->
      @settings.errorClass

    isSetStatusClass: () ->
      @settings.setStatusClass

    useDefaultErrorHandler: () ->
      @settings.defaultErrorHandler

    useGlobalNamespace: () ->
      @settings.globalNamespace