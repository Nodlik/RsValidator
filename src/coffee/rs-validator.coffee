define ['rs-error-parser', 'rs-email-rule'], (RsErrorParser, RsEmailRule) ->

  class RsValidator
    constructor: () ->
      console.log( RsEmailRule(['asd@asdss.asd', 'asd@asds.asd']) );