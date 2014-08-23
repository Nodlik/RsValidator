require(['rs-validator',
         'rs-error-parser', 'rs-email-rule',
         'rs-notBlank-rule'], function (RsValidator, RsErrorParser,
                                        RsEmailRule,
                                        RsNotBlankRule) {
    window.RsEmailRule = RsEmailRule;
    window.RsErrorParser = RsErrorParser;
    window.RsNotBlankRule = RsNotBlankRule;

    new RsValidator();
});