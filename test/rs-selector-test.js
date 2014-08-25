describe("Selector parser test", function () {
    it("get namespace list", function () {
        var parser = new window.RsSelectorParser();
        expect(parser.parse('namespace1,         namespace2,       namespace3.widgetName'))
            .toEqual([{namespace: 'namespace1'}, {namespace: 'namespace2'}, {namespace: 'namespace3', widget: 'widgetName'}]);
    });

    it("get widget with namespace", function () {
        var parser = new window.RsSelectorParser();
        expect(parser.parse('namespace1.widgetName'))
            .toEqual([{namespace: 'namespace1', widget: 'widgetName'}]);
    });
});