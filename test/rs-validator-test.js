describe("Validate email", function () {
    it("a single value", function () {
        expect(window.RsEmailRule('asd@asd.asd')).toBe(true);
        expect(window.RsEmailRule('asd@asd')).toBe(false);
    });

    it("an array", function () {
        expect(window.RsEmailRule(['asd@asd.asd', 'wqe@asd.ew', 'awqe@qwe.ed'])).toBe(true);
        expect(window.RsEmailRule(['asd@asd.asd', 'wqe@asd', 'awqe@qwe.edw'])).toBe(false);
    });
});

describe("Validate to not blank", function () {
    it("a single value", function () {
        expect(window.RsNotBlankRule("hello")).toBe(true);
        expect(window.RsNotBlankRule("")).toBe(false);
        expect(window.RsNotBlankRule(0)).toBe(true);
        expect(window.RsNotBlankRule(false)).toBe(true);
    });

    it("an array", function () {
        expect(window.RsNotBlankRule(["a", ''])).toBe(false);
        expect(window.RsNotBlankRule(["a", 0])).toBe(true);
    });
});