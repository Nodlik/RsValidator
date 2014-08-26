define ['rs-validator-settings'], (RsValidatorSettings) ->

  class RsWidgetCollection
    constructor: (validator) ->
      @config = new RsValidatorSettings()
      @validator = validator

      @widgets = []

    setConfig: (settings) ->
      @config.set(settings)

      if 'onError' of settings
        delete settings.onError

      if 'onValid' of settings
        delete settings.onValid

      if 'onChange' of settings
        delete settings.onChange

      for w in @widgets
        w.setConfig(settings)

      @

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

      self = @
      widget.on('change', (w) ->
        self.config.change.apply(self.validator, [w])

        if self.isValid()
          self.config.valid.apply(self.validator, [w])
        else
          self.config.error.apply(self.validator, [w, []])
      )

      @

    validate: () ->
      result = {}

      for w in @widgets
        errors = w.validate()
        if errors.length
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

    renderError: (errors) ->
      for w in @widgets
        w._isValid = false
        w.renderError(errors)

      @

    addRule: (rule, option = true) ->
      for w in @widgets
        w.addRule(rule, option)

      @

    addRules: (rules) ->
      for w in @widgets
        w.addRules(rules)

      @