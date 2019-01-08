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
        console.log('*** Get Rating ***');
        var action = component.get("c.getRating");
        action.setParams({
            "application": application
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                // Update rating field on the action item in the list  
                var applications = component.get("v.referredApplications");
                
                for (var i = 0; i < applications.length; i++) {
                    if (applications[i].Id == application.Id) {
                        applications[i].Credit_R__c = response.getReturnValue().Credit_R__c;
                        break;
                    }
                }
                
                // applications.push(response.getReturnValue());
                
                component.set("v.referredApplications", applications); 
            }
        });
        $A.enqueueAction(action);
    },

})