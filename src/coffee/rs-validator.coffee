define ['rs-validator-settings', 'rs-widget', 'rs-widget-collection', 'rs-namespace', 'rs-form',
        'rs-selector-parser', 'rs-validate-controller'], (RsValidatorSettings, RsWidget, RsWidgetCollection, RsNamespace, RsForm,
                                                          RsSelectorParser, RsValidateController) ->

  class RsValidator
    constructor: () ->
      @config = new RsValidatorSettings()
      @selectorParser = new RsSelectorParser()
      @validateController = new RsValidateController(@)

      @namespaces = {}
      @widgets = []

    getValidateController: () ->
      @validateController

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

    get: (selector, collection = null) ->
      parsedResult = @selectorParser.parse(selector)

      result = collection
      if (result == null)
        result = new RsWidgetCollection(@)

      for value in parsedResult
        if value.namespace of @namespaces
          if 'widget' of value
            if @namespaces[value.namespace].has(value.widget)
              result.add(@namespaces[value.namespace].get(value.widget))
          else
            for name, w of @namespaces[value.namespace].widgets
              result.add(w)
        else if !('widget' of value)
          for w in @getWidgetsByName(value.namespace)
            result.add(w)

      result

    getWidgetsByName: (widgetName) ->
      result = []
      for w in @widgets
        if w.getName() == widgetName
          result.push(w)

      result

    addScope: ($scope) ->
      $items = $('[data-_rule], [data-_namespace], [data-_error], [data-_name], [data-_validate="true"], [data-_type]', $scope).filter(
        () ->
          return $(@).closest('form').length == 0
      )

      $forms = $('form[data-_role], form[data-_namespace], form[data-_name], form[data-_validate="true"]', $scope)

      self = @
      $items.each () ->
        if !($(@).prop('tagName') == 'FORM')
          self.processWidget($(@), '', $scope)

      $forms.each () ->
        self.processForm($(@))

      @

    addWidget: ($widget, namespace = '', $parent = null) ->
      collection = new RsWidgetCollection(@);

      self = this;
      $widget.each(() ->
        if !($(this).prop('tagName') == 'FORM')
          w = self.processWidget($(this), namespace, $parent)
          collection.add(w)
        else
          form = self.processForm ($widget)
          self.get(form.getName(), collection)
      )

      collection

    init: ($parent = null) ->
      if ($parent == null)
        $parent = $('body')

      @namespaces = {}
      @widgets = []

      @addScope($parent)

    getNamespace: (namespace) ->
      if !(namespace of @namespaces)
        newNamespace = new RsNamespace(namespace)
        @namespaces[namespace] = newNamespace

      @namespaces[namespace]

    processForm: ($form) ->
      new RsForm($form, @)

    processWidget: ($widget, firstNamespace = '', $parent = null) ->
      namespaces = []
      if firstNamespace != ''
        namespaces = [firstNamespace]

      if ($widget.data('_namespace'))
        namespaces = $widget.data('_namespace')
        namespaces = namespaces.split(',');
        if firstNamespace != ''
          namespaces.push(firstNamespace)

      if (namespaces.length == 0) or (@config.useGlobalNamespace())
        namespaces.push('_')

      widget = new RsWidget($widget, @validateController, $parent)
      widget.setConfig(@config.settings)

      namespacesName = ''
      for namespace in namespaces
        if namespace.trim() != ''
          objectNamespace = @getNamespace(namespace.trim())
          objectNamespace.add(widget)
          namespacesName += namespace.trim() + '.'

      @widgets.push( widget )

      widget