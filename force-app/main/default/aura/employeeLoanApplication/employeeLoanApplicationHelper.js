({
    createApplication: function(component, application) {
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