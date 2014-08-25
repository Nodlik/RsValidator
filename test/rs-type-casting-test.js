describe("Try cast", function () {
    it("string to int", function () {
        expect(window.RsIntValidate("1")).toBe(1);
        expect(window.RsIntValidate("211")).toBe(211);
        expect(window.RsIntValidate("1a")).toEqual(jasmine.objectContaining({
            value: "1a"
        }));
    });
});