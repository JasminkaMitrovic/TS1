({
	handleUpdateApplication: function(component, event, helper) {
        var updatedApplication = event.getParam("application");
        helper.updateApplication(component, updatedApplication);
    }

})