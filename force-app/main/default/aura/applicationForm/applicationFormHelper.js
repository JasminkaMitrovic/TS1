({
	createApplication: function(component, newApplication) {
        var createEvent = component.getEvent("createApplication");
        createEvent.setParams({ "application": newApplication });
        createEvent.fire();
    },

})