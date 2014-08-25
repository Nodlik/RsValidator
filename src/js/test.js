require(['rs-validator',
         'rs-error-parser', 'rs-email-rule',
         'rs-notBlank-rule', 'rs-string-parser',
         'rs-rule-parser', 'rs-int-validate',
         'rs-array-validate', 'rs-selector-parser'], function (RsValidator, RsErrorParser,
                                        RsEmailRule,
                                        RsNotBlankRule,
                                        RsStringParser, RsRuleParser, RsIntValidate,
                                        RsArrayValidate, RsSelectorParser) {
    window.RsEmailRule = RsEmailRule;
    window.RsErrorParser = RsErrorParser;
    window.RsNotBlankRule = RsNotBlankRule;
    window.RsStringParser = RsStringParser;

    window.RsRuleParser = RsRuleParser;
    window.RsErrorParser = RsErrorParser;

    window.RsIntValidate = RsIntValidate;
    window.RsArrayValidate = RsArrayValidate;
    window.RsSelectorParser = RsSelectorParser;
});