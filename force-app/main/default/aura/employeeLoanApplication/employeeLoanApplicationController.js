({
    // Load applications from Salesforce
    doInit: function(component, event, helper) {
        // Create the action
        var action = component.get("c.getApplications");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Sucess!");
                var applicationsList = response.getReturnValue();
                
                // Iterate returned applications and see if there is any with the 
                // status of Approved. If so, set the 'approvedExistsInd' to true.
                var approvedPositionIndex = -3;
                for (var i = 0; i < applicationsList.length; i++) {
                    if (applicationsList[i].Status__c == 'Approved') {
                        component.set("v.approvedExistsInd", true);
                        component.set("v.approvedApplication", applicationsList[i]);
                        approvedPositionIndex = i;
                        break;
                    }
                } 
                
                if (approvedPositionIndex > -3) {
                    applicationsList.splice(approvedPositionIndex, 1);
                }
                
                component.set("v.applications", applicationsList);
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