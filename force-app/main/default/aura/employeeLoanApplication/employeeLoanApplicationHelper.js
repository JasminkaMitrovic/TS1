({
    createApplication: function(component, application) {
        /*
        var theApplications = component.get("v.applications");
        // Copy the application to a new object
        // THIS IS A DISGUSTING, TEMPORARY HACK
        var newApplication = JSON.parse(JSON.stringify(application));
        theApplications.push(newApplication);
        component.set("v.applications", theApplications);
        */
        
        var action = component.get("c.saveApplication");
        action.setParams({
            "application": application
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var applications = component.get("v.applications");
                applications.push(response.getReturnValue());
                component.set("v.applications", applications);
            }
        });
        $A.enqueueAction(action);
    }
})