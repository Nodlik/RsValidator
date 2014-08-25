define ['rs-validator-settings', 'rs-widget', 'rs-widget-collection', 'rs-namespace', 'rs-form',
        'rs-selector-parser'], (RsValidatorSettings, RsWidget, RsWidgetCollection, RsNamespace, RsForm,
                                RsSelectorParser) ->

  class RsValidator
    constructor: () ->
      @config = new RsValidatorSettings()
      @selectorParser = new RsSelectorParser()

      @namespaces = {}
      @widgets = []

      @init()

    setConfig: (settings) ->
      @config.set(settings)

    getConfig: () ->
      @config

    get: (selector) ->
      parsedResult = @selectorParser.parse(selector)

      result = new RsWidgetCollection()
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

    init: ($parent = null) ->
      if ($parent == null)
        $parent = $('body')

      @namespaces = {}
      @widgets = []

      $items = $('[data-_rule], [data-_namespace], [data-_error], [data-_name], [data-_validate]', $parent).filter(
        () ->
          return $(@).closest('form').length == 0
      )

      $forms = $('form[data-_role], form[data-_namespace], form[data-_name], form[data-_validate]', $parent)

      self = @
      $items.each () ->
        if !($(@).prop('tagName') == 'FORM')
          self.processWidget($(@))

      $forms.each () ->
        self.processForm($(@))

    processWidget: ($widget, firstNamespace = '') ->
      if firstNamespace == ''
        namespaces = ['_'];
      else
        namespaces = [firstNamespace]
      if ($widget.data('_namespace'))
        namespaces = $widget.data('_namespace')
        namespaces = namespaces.split(',');
        if firstNamespace != ''
          namespaces.push(firstNamespace)

      widget = new RsWidget($widget)

      namespacesName = ''
      for namespace in namespaces
        if namespace.trim() != ''
          objectNamespace = @getNamespace(namespace.trim())
          objectNamespace.add(widget)
          namespacesName += namespace.trim() + '.'

      @widgets.push( widget )


    getNamespace: (namespace) ->
      if !(namespace of @namespaces)
        newNamespace = new RsNamespace(namespace)
        @namespaces[namespace] = newNamespace

      @namespaces[namespace]

    processForm: ($form) ->
      new RsForm($form, @)