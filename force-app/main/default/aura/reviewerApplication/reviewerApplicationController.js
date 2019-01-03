({
    // Load applications from Salesforce
    doInit: function(component, event, helper) {
        // Create the action
        var action = component.get("c.getApplications");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.referredApplications", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
    handleCreateApplication: function(component, event, helper) {
        var newApplication = event.getParam("application");
        helper.createApplication(component, newApplication);
    },

})