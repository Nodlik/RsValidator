describe("Validators Email test", function () {
    it("", function () {
        expect(window.RsEmailRule('asd@asd.asd')).toBe(true);
    });
    it("", function () {
        expect(window.RsEmailRule('asd@asd')).toBe(false);
    });
    it("", function () {
        expect(window.RsEmailRule(['asd@asd.asd', 'wqe@asd.ew', 'awqe@qwe.ed'])).toBe(true);
    });
    it("", function () {
        expect(window.RsEmailRule(['asd@asd.asd', 'wqe@asd', 'awqe@qwe.ed'])).toBe(false);
    });
});

describe("Validators notBlank test", function () {
    it("", function () {
        expect(window.RsNotBlankRule("hello")).toBe(true);
    });
    it("", function () {
        expect(window.RsNotBlankRule("")).toBe(false);
    });
    it("", function () {
        expect(window.RsNotBlankRule(0)).toBe(true);
    });
    it("", function () {
        expect(window.RsNotBlankRule(false)).toBe(true);
    });
    it("", function () {
        expect(window.RsNotBlankRule(["a", 0])).toBe(true);
    });
    it("", function () {
        expect(window.RsNotBlankRule(["a", ''])).toBe(false);
    });
});