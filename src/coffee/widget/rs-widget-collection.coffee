define ['rs-validator-settings'], (RsValidatorSettings) ->

  class RsWidgetCollection
    constructor: () ->
      @config = new RsValidatorSettings()
      @widgets = []

    setConfig: (settings) ->
      @config.set(settings)

      for w in @widgets
        w.setConfig(settings)

    getConfig: () ->
      @config

    setLocale: (lang) ->
      @config.settings.locale = lang

      for w in @widgets
        w.setLocale(lang)

      @

    getSingleValue: () ->
      result = []
      if @widgets.length == 1
        return @widgets[0].getValue()

      for w in @widgets
        result.push(w.getValue())

      result

    getValue: () ->
      result = {}

      for w in @widgets
        result[w.getName()] = w.getValue()

      result

    add: (widget) ->
      @widgets.push(widget)

      @

    validate: () ->
      result = {}

      for w in @widgets
        result[w.getName()] = w.validate()

      result

    isValid: () ->
      return Object.keys(@validate()).length == 0

    process: () ->
      result = true
      for w in @widgets
        if !w.process()
          result = false

      return result

    addErrorText: (rule, text, lang = '') ->
      for w in @widgets
        w.addErrorText(rule, text, lang)

      @