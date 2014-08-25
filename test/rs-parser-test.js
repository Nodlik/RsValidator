describe("String parser test", function () {
    it("Common test", function () {
        var parser = new window.RsStringParser();
        expect(parser.parse('one(0, 10), two')).toContain({'word': 'two'});

        var f = function() {
            parser.parse('one(0, 10), two, ');
        };

        expect(f).toThrow();
    });

    it("Parameter test", function () {
        var parser = new window.RsStringParser();
        expect(parser.parse('one(0, 10), two, three(213, "qwe")'))
            .toContain({'word': 'three', 'parameters': ['213', "qwe"]});

        expect(parser.parse('one(0, 10), two, three(213, "qwe")'))
            .toContain({'word': 'one', 'parameters': ['0', '10']});
    });

    it("Empty", function () {
        var parser = new window.RsStringParser();
        expect(parser.parse(''))
            .toEqual([]);
    });
});

describe("Rule parser test", function () {
    it("JSON", function () {
        var parser = new window.RsRuleParser();
        expect(parser.parse('{ "notBlank": true, "range": {"min": 10, "max": 20} }'))
            .toEqual({ "notBlank": true, "range": {"min": 10, "max": 20} });
    });

    it("Text", function () {
        var parser = new window.RsRuleParser();
        expect(parser.parse('notBlank, range(10, 20)'))
            .toEqual({ "notBlank": true, "range": ['10', '20'] });
    });

    it("Empty", function () {
        var parser = new window.RsRuleParser();
        expect(parser.parse(''))
            .toEqual({});
    });
});

describe("Error parser test", function () {
    it("JSON", function () {
        var parser = new window.RsErrorParser();
        expect(parser.parse('{ "notBlank": { "en": "required", "fr": "exiger"} }'))
            .toEqual({ "notBlank": { "en": "required", "fr": "exiger"} });
    });

    it("Text", function () {
        var parser = new window.RsErrorParser();
        expect(parser.parse('notBlank("en": "required", "fr": "exiger")'))
            .toEqual({ "notBlank": { "en": "required", "fr": "exiger"} });
    });
});