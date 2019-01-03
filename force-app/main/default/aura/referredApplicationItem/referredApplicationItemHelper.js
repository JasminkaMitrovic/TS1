({
	updateApplication: function(component, newApplication) {
        var createEvent = component.getEvent("updateApplication");
        createEvent.setParams({ "application": newApplication });
        createEvent.fire();
    },
})