define ['rs-state-transition'
        'rs-state-new',
        'rs-state-word',
        'rs-state-parameters-start',
        'rs-state-parameters-stop',
        'rs-state-parameter-new',
        'rs-state-parameter-value',
        'rs-state-string-start',
        'rs-state-string-escape'], (RsStateTransition,
                           RsStateNew,
                           RsStateWord,
                           RsStateParametersStart,
                           RsStateParametersStop,
                           RsStateParameterNew,
                           RsStateParameterValue,
                           RsStateStringStart,
                           RsStateStringEscape) ->

  class RsStringParser
    state = new RsStateNew()
    symbol = ""

    constructor: () ->
      @transition = new RsStateTransition();

      @state = {
        new: () ->
          new RsStateNew()
        word: () ->
          new RsStateWord()
        parametersStart: () ->
          new RsStateParametersStart()
        parametersStop: () ->
          new RsStateParametersStop()
        parameterNew: () ->
          new RsStateParameterNew()
        parameterValue: () ->
          new RsStateParameterValue()
        stringStart: () ->
          new RsStateStringStart()
        stringEscape: () ->
          new RsStateStringEscape()
      };

    parse: (str) ->
      @data = []

      @word = ""
      @parameters = []
      @parameter = ""
      @stringValue = ""

      for w in str
        symbol = w
        state = state.process(this, w)

      return @data

    setTransition: (oldState, newState) ->
      @transition.setTransition(oldState, newState, this, symbol)