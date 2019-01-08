({
	handleUpdateApplication: function(component, event, helper) {
        var updatedApplication = event.getParam("application");
        helper.updateApplication(component, updatedApplication);
    },
    
    handleGetRating: function(component, event, helper) {
        helper.getRating(component, event.getParam("application"));
    },

})