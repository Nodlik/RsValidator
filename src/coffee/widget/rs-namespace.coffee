define [], () ->

  class RsNamespace
    constructor: (name) ->
      @name = name
      @widgets = {}

    add: (widget) ->
      if widget.getName() of @widgets
        throw new Error('Widget whit this name and namespace already added')

      @widgets[widget.getName()] = widget

    has: (widgetName) ->
      widgetName of @widgets

    get: (widgetName) ->
      @widgets[widgetName]