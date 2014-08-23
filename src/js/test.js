require(['rs-validator',
         'rs-error-parser', 'rs-email-rule',
         'rs-notBlank-rule', 'rs-string-parser',
         'rs-rule-parser', 'rs-error-parser'], function (RsValidator, RsErrorParser,
                                        RsEmailRule,
                                        RsNotBlankRule,
                                        RsStringParser, RsRuleParser, RsErrorParser) {
    window.RsEmailRule = RsEmailRule;
    window.RsErrorParser = RsErrorParser;
    window.RsNotBlankRule = RsNotBlankRule;
    window.RsStringParser = RsStringParser;

    window.RsRuleParser = RsRuleParser;
    window.RsErrorParser = RsErrorParser;

    new RsValidator();
});