({
	updateApplication: function(component, application) {
        var action = component.get("c.saveApplication");
        action.setParams({
            "application": application
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                // do nothing!
            }
        });
        $A.enqueueAction(action);
    },
    
    getRating: function(component, application) {
        var action = component.get("c.getRating");
        action.setParams({
            "application": application
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                // TODO: Update rating field on the action
            }
        });
        $A.enqueueAction(action);
    },

})