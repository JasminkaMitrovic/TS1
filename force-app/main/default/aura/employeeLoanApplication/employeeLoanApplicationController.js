({
    // Load applications from Salesforce
    doInit: function(component, event, helper) {
        // Create the action
        var action = component.get("c.getApplications");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Success!");
                var applicationsList = response.getReturnValue();
                
                if (applicationsList.length > 0) {
                    component.set("v.userName", applicationsList[0].Name);
                }
                
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
        
        /* This is how to access current user ID, but it is not working for
         * Name, Username, FirstName...
         * 
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        var userName = $A.get("$SObjectType.CurrentUser.LastName");
        var currentUser = $A.get("$SObjectType.CurrentUser");
        console.log('**** userId: ' + userId);
        console.log('**** userName: ' + userName);
        component.set("v.userName", userName);
        */
        
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
    handleCreateApplication: function(component, event, helper) {
        var newApplication = event.getParam("application");
        helper.createApplication(component, newApplication);
    },

})