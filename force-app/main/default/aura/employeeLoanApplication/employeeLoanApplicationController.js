({
    // Load applications from Salesforce
    doInit: function(component, event, helper) {
        // Create the action
        var action = component.get("c.getApplications");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.applications", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
    clickCreate: function(component, event, helper) {
        var validApplication = component.find('expenseform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validApplication){
            // Create the new expense
            var newApplication = component.get("v.newApplication");
            console.log("Create expense: " + JSON.stringify(newApplication));
            helper.createApplication(component, newApplication);
        }
    }
})